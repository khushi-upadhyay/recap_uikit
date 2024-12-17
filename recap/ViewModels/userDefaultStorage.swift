//
//  userDefaultStorage.swift
//  recap
//
//  Created by Diptayan Jash on 15/12/24.
//

import Foundation
import UIKit

protocol ProfileStorageProtocol {
    func saveProfile(details: [String: Any], image: UIImage?, completion: @escaping (Bool) -> Void)
    func getProfile() -> [String: Any]?
    func getProfileImage() -> UIImage?
    func hasCompletedProfile() -> Bool
    func clearProfile()
    func isLoggedIn() -> Bool
}

protocol FamilyStorageProtocol {
    func saveFamilyMember(_ member: FamilyMember, image: UIImage?, completion: @escaping (Bool) -> Void)
    func getFamilyMembers() -> [FamilyMember]
    func getFamilyMemberImage(for id: UUID) -> UIImage?
    func clearFamilyData()
}

private let defaults = UserDefaults.standard

class UserDefaultsStorageProfile: ProfileStorageProtocol {
    static let shared = UserDefaultsStorageProfile()

//    private let defaults = UserDefaults.standard

    private enum Keys {
        static let profileImage = "profileImage"
        static let patientProfile = "PatientProfile"
        static let hasCompletedProfile = "hasCompletedProfile"
        static let isLoggedIn = "isLoggedIn"
    }

    func saveProfile(details: [String: Any], image: UIImage?, completion: @escaping (Bool) -> Void) {
//        print("Saving profile details:", details)

        if let image = image,
           let imageData = image.jpegData(compressionQuality: 0.8) {
            defaults.set(imageData, forKey: Keys.profileImage)
        }

        defaults.set(details, forKey: Keys.patientProfile)
        defaults.set(true, forKey: Keys.hasCompletedProfile)
        defaults.set(true, forKey: Keys.isLoggedIn)
        defaults.synchronize()

        // Verify saved data
        if let savedDetails = defaults.dictionary(forKey: Keys.patientProfile) {
            print("Verified saved details:", savedDetails)
            completion(true)
        } else {
            completion(false)
        }
    }

    func getProfile() -> [String: Any]? {
        let profile = defaults.dictionary(forKey: Keys.patientProfile)
//        print("Retrieved profile:", profile ?? "No profile found")
        return profile
    }

    func getProfileImage() -> UIImage? {
        guard let imageData = defaults.data(forKey: Keys.profileImage) else { return nil }
        return UIImage(data: imageData)
    }

    func hasCompletedProfile() -> Bool {
        return defaults.bool(forKey: Keys.hasCompletedProfile)
    }

    func clearProfile() {
        UserDefaults.standard.removeObject(forKey: Keys.patientProfile)
        UserDefaults.standard.removeObject(forKey: Keys.profileImage)
        UserDefaults.standard.removeObject(forKey: Keys.isLoggedIn)
        UserDefaults.standard.synchronize()
    }

    func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: Keys.isLoggedIn)
    }
}

class UserDefaultsStorageFamilyMember: FamilyStorageProtocol {
    static let shared = UserDefaultsStorageFamilyMember()
    private init() {}
//    private let defaults = UserDefaults.standard

    private enum Keys {
        static let familyMembers = "familyMembers"
        static let familyImages = "familyImages"
    }

    // MARK: - Family Members Storage

    func saveFamilyMember(_ member: FamilyMember, image: UIImage?, completion: @escaping (Bool) -> Void) {
        var familyMembers = getFamilyMembers()
        familyMembers.append(member)

        // Save member data
        if let encoded = try? JSONEncoder().encode(familyMembers) {
            defaults.set(encoded, forKey: Keys.familyMembers)
        }

        // Save image if provided
        if let image = image,
           let imageData = image.jpegData(compressionQuality: 0.8) {
            var imageDict = defaults.dictionary(forKey: Keys.familyImages) as? [String: Data] ?? [:]
            imageDict[member.id.uuidString] = imageData
            defaults.set(imageDict, forKey: Keys.familyImages)
        }

        defaults.synchronize()
        completion(true)
    }

    func getFamilyMembers() -> [FamilyMember] {
        guard let data = defaults.data(forKey: Keys.familyMembers),
              let members = try? JSONDecoder().decode([FamilyMember].self, from: data) else {
            return []
        }
        return members
    }

    func getFamilyMemberImage(for id: UUID) -> UIImage? {
        guard let imageDict = defaults.dictionary(forKey: Keys.familyImages) as? [String: Data],
              let imageData = imageDict[id.uuidString] else {
            return nil
        }
        return UIImage(data: imageData)
    }

    func clearFamilyData() {
        defaults.removeObject(forKey: Keys.familyMembers)
        defaults.removeObject(forKey: Keys.familyImages)
        defaults.synchronize()
    }
}
