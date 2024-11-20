//
//  QuestionsDataModel.swift
//  recap
//
//  Created by Diptayan Jash on 09/11/24.
//

import Foundation
enum QuestionCategory: String, Codable {
    case immediateMemory
    case recentMemory
    case remoteMemory
}

enum QuestionSubcategory: String, Codable {
    case dailyRoutine
    case general
    case health
    case family
    case spiritual
    case hobbies
    case musicMovies
}

// Questions Model
struct Question: Identifiable, Codable {
    var id = UUID()
    var text: String
    var category: QuestionCategory
    var subcategory: QuestionSubcategory
    var tag: String? // e.g., "Medication", "Eating", etc.
    var answerOptions: [String]
}
