//
//  RecentDataModel.swift
//  Recap
//
//  Created by admin70 on 29/10/24.
//

import Foundation
import SwiftUI

// Monthly Memory Tracking Model (Recent)
struct RecentMemoryData: Identifiable {
    let id = UUID()
    let month: String // e.g., "January", "February"
    let correctAnswers: Int
    let incorrectAnswers: Int
    var status: MemoryStatus
}

let recentMemoryData = [
    RecentMemoryData(month: "January", correctAnswers: 15, incorrectAnswers: 5, status: .improving),
    RecentMemoryData(month: "February", correctAnswers: 12, incorrectAnswers: 8, status: .processing)
]
