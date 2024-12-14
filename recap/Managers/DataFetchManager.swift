//
//  DataFetchmanager.swift
//  recap
//
//  Created by Diptayan Jash on 14/12/24.
//

import Foundation

protocol DataFetchProtocol {
    func fetchRapidQuestions(completion: @escaping ([rapiMemory]?, Error?) -> Void)
    func fetchInfo(completion: @escaping (String, Error?) -> Void)
    
}

class DataFetch: DataFetchProtocol {
    func fetchRapidQuestions(completion: @escaping ([rapiMemory]?, Error?) -> Void) {
        FirebaseManager.shared.fetchData(DBName: "rapidMemoryQuestions") { (data: [rapiMemory]?, error) in
            completion(data, error)
        }
    }
    func fetchInfo(completion: @escaping (String, Error?) -> Void) {
        
    }
}
