//
//  FamilyDataModel.swift
//  recap
//
//  Created by Diptayan Jash on 05/11/24.
//

import Foundation
import UIKit

enum RelationshipCategory: String, Codable, CaseIterable {
    case Son
    case Daughter
    case Husband
    case Wife
    case Father
    case Mother
    case Brother
    case Sister
}

struct FamilyMember: Identifiable, Equatable {
    let id = UUID()
    let name: String
//    let relationship: RelationshipCategory
    let relationship: String
    let phone: String
    let email: String
    let imageName: String
}
