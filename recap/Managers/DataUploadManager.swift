//
//  DataUpload.swift
//  recap
//
//  Created by Diptayan Jash on 14/12/24.
//

import Foundation

protocol DataUploadProtocol {
    func saveUserDetails(_ details: UserDetails, completion: @escaping (Error?) -> Void)
}

class DataUpload: DataUploadProtocol {
    func saveUserDetails(_ details: UserDetails, completion: @escaping (Error?) -> Void) {
        // Fire base Manager
    }
}
