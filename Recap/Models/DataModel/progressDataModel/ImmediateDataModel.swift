//
//  ImmediateDataModel.swift
//  Recap
//
//  Created by admin70 on 29/10/24.
//

import Foundation
import SwiftUI

// Define an Enum for Status
enum MemoryStatus: String {
    case improving, processing, stable, declining
    
    var color: Color {
        switch self {
        case .improving: return .green
        case .processing: return .yellow
        case .stable: return .blue
        case .declining: return .red
        }
    }
}

// Daily Memory Tracking Model (Immediate)
struct ImmediateMemoryData: Identifiable {
    let id = UUID()
    let date: Date
    let correctAnswers: Int
    let incorrectAnswers: Int
    var status: MemoryStatus
}

let immediateMemoryData = [
    ImmediateMemoryData(date: Date(), correctAnswers: 8, incorrectAnswers: 2, status: .improving),
    ImmediateMemoryData(date: Date().addingTimeInterval(-86400), correctAnswers: 7, incorrectAnswers: 3, status: .stable)
]
