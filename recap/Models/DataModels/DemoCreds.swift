//
//  DemoCreds.swift
//  recap
//
//  Created by Diptayan Jash on 15/12/24.
//

import Foundation

struct UserCredentials {
    let email: String
    let password: String
    let firstName: String
    let lastName: String
}

let demoUsers: [UserCredentials] = [
    UserCredentials(email: "user1@example.com", password: "password1", firstName: "John", lastName: "Doe"),
    UserCredentials(email: "user2@example.com", password: "password2", firstName: "Jane", lastName: "Smith"),
    UserCredentials(email: "user3@example.com", password: "password3", firstName: "Alice", lastName: "Johnson"),
    UserCredentials(email: "user4@example.com", password: "password4", firstName: "Bob", lastName: "Brown")
]
