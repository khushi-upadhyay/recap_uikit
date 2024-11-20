//
//  GamesDataModel.swift
//  recap
//
//  Created by Diptayan Jash on 09/11/24.
//

import Foundation
struct Games: Identifiable, Equatable {
    let id = UUID()
    let imageName: String
    let name: String
    let description: String
    let screenName: String
}
