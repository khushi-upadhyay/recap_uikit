//
//  FirebaseManager.swift
//  recap
//
//  Created by Diptayan Jash on 14/12/24.
//

import FirebaseDatabase
import Foundation

class FirebaseManager {
    static let shared = FirebaseManager()
    
    private let databaseRef = Database.database().reference()
    
    func fetchData<T: FireBaseDecodable>(DBName: String, completion: @escaping ([T]?, Error?) -> Void) {
        let databaseReference = databaseRef.child(DBName)
        databaseReference.observeSingleEvent(of: .value, with: { snapshot in
            print("Firebase raw data:", snapshot.value ?? "no data")
            guard let dataList = snapshot.value as? [[String: Any]?] else {
                completion(nil, NSError(domain: "FirebaseError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Invalid data format"]))
                return
            }
            
            let data:[T] = dataList.compactMap { dict in
                guard let dict = dict else { return nil }
                return T(id: dict.keys.first!, fireData: dict)
            }
            completion(data, nil)
            
        }) { error in
            completion(nil, error)
        }
    }
    
    func saveUserProfile(_ details: UserDetails, completion: @escaping (Error?) -> Void) {
        // TODO: Implement Firebase storage logic
        // 1. Upload profile image if exists
        // 2. Save user details to Firestore
        completion(nil)
    }
}
