//
//  RemoteDataModel.swift
//  Recap
//
//  Created by admin70 on 29/10/24.
//

import Foundation
import SwiftUI

// Yearly Memory Tracking Model (Remote)
struct RemoteMemoryData: Identifiable {
    let id = UUID()
    let year: Int
    let monthlyScores: [Int] // Array of scores per month
    var status: MemoryStatus
}

let remoteMemoryData = [
    RemoteMemoryData(year: 2023, monthlyScores: [10, 12, 8, 15, 13, 11, 14, 10, 9, 13, 14, 12], status: .stable),
    RemoteMemoryData(year: 2024, monthlyScores: [12, 11, 10, 14, 15, 13, 9, 8, 10, 11, 12, 14], status: .improving)
]
