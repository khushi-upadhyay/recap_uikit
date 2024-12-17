//
//  DataFetchmanager.swift
//  recap
//
//  Created by Diptayan Jash on 14/12/24.
//

import Foundation

protocol DataFetchProtocol {
    func fetchRapidQuestions(completion: @escaping ([rapiMemory]?, Error?) -> Void)
    func fetchPatientProfile(completion: @escaping (UserDetails?, Error?) -> Void)
    
}

class DataFetch: DataFetchProtocol {
    func fetchRapidQuestions(completion: @escaping ([rapiMemory]?, Error?) -> Void) {
        FirebaseManager.shared.fetchData(DBName: "rapidMemoryQuestions") { (data: [rapiMemory]?, error) in
            completion(data, error)
        }
    }
    func fetchPatientProfile(completion: @escaping (UserDetails?, Error?) -> Void) {
            FirebaseManager.shared.fetchData(DBName: "PatientProfile") { (data: [UserDetails]?, error) in
                completion(data?.first, error)
            }
        }
}
