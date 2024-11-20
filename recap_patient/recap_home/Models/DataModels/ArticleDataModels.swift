//
//  ArticleDataModels.swift
//  recap
//
//  Created by Diptayan Jash on 05/11/24.
//

import Foundation
struct Article: Identifiable, Equatable {
    let id = UUID() // Unique identifier
    let image: String
    let title: String
    let subtitle: String
    let content: String
}
