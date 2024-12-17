import Foundation

struct UserDetails:Codable, FireBaseDecodable {
    var firstName: String
    var lastName: String
    var dateOfBirth: String
    var sex: String
    var bloodGroup: String
    var stage: String
    var profileImageURL: String?
//    var familyMembers: [FamilyMember] = []
    var id: String
    
    // Default initializer
    init(firstName: String = "",
         lastName: String = "",
         dateOfBirth: String = "",
         sex: String = "",
         bloodGroup: String = "",
         stage: String = "",
         profileImageURL: String? = nil) {
        self.id = UUID().uuidString
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.sex = sex
        self.bloodGroup = bloodGroup
        self.stage = stage
        self.profileImageURL = profileImageURL
    }
    
    // FirebaseDecodable initializer
    init(id: String, fireData: Any) {
        self.id = id
        if let data = fireData as? [String: Any] {
            firstName = data["firstName"] as? String ?? ""
            lastName = data["lastName"] as? String ?? ""
            dateOfBirth = data["dateOfBirth"] as? String ?? ""
            sex = data["sex"] as? String ?? ""
            bloodGroup = data["bloodGroup"] as? String ?? ""
            stage = data["stage"] as? String ?? ""
            profileImageURL = data["profileImageURL"] as? String
        } else {
            firstName = ""
            lastName = ""
            dateOfBirth = ""
            sex = ""
            bloodGroup = ""
            stage = ""
            profileImageURL = nil
        }
    }
    
    // UserDefaults keys
        static let userDefaultsKey = "PatientProfile"
        
        // Save to UserDefaults
        func saveToUserDefaults() {
            if let encoded = try? JSONEncoder().encode(self) {
                UserDefaults.standard.set(encoded, forKey: UserDetails.userDefaultsKey)
            }
        }
        
        // Load from UserDefaults
        static func loadFromUserDefaults() -> UserDetails? {
            if let data = UserDefaults.standard.data(forKey: userDefaultsKey) {
                return try? JSONDecoder().decode(UserDetails.self, from: data)
            }
            return nil
        }
}


enum SexOptions: String, Codable, CaseIterable {
    case Male
    case Female
    case Other
}

enum BloodGroupOptions: String, Codable, CaseIterable {
    case APlus = "A+"
    case AMinus = "A-"
    case BPlus = "B+"
    case BMinus = "B-"
    case OPlus = "O+"
    case OMinus = "O-"
    case ABPlus = "AB+"
    case ABMinus = "AB-"
}

enum StageOptions: String, Codable, CaseIterable {
    case Early
    case Middle
    case Advanced
}
