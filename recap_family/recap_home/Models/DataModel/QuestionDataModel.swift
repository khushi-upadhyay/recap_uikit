//
//  Questions.swift
//  Recap
//
//  Created by admin70 on 18/11/24.

import Foundation
import UIKit

struct Question: Identifiable, Codable {
    var id = UUID()
    let title: String
    let options: [String]
    let image: String?
}

