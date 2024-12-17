//
//  FirebaseManager.swift
//  recap
//
//  Created by Diptayan Jash on 14/12/24.
//

import FirebaseDatabase
import Foundation
import FirebaseStorage

class FirebaseManager {
    static let shared = FirebaseManager()
    private let databaseRef = Database.database().reference()
    private let storage = Storage.storage().reference()
    
    func fetchData<T: FireBaseDecodable>(DBName: String, completion: @escaping ([T]?, Error?) -> Void) {
        let databaseReference = databaseRef.child(DBName)
        databaseReference.observeSingleEvent(of: .value, with: { snapshot in
            print("Firebase raw data:", snapshot.value ?? "no data")
            
            if let dict = snapshot.value as? [String: Any] {
                let items = [T(id: dict["id"] as? String ?? UUID().uuidString, fireData: dict)]
                completion(items, nil)
            } else if let dataList = snapshot.value as? [[String: Any]?] {
                let data:[T] = dataList.compactMap { dict in
                    guard let dict = dict else { return nil }
                    return T(id: dict["id"] as? String ?? UUID().uuidString, fireData: dict)
                }
                completion(data, nil)
            } else {
                completion(nil, NSError(domain: "FirebaseError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Invalid data format"]))
            }
        }) { error in
            completion(nil, error)
        }
    }
}
