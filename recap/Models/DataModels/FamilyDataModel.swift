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

struct FamilyMember:Codable, Identifiable, Equatable {
    var id = UUID()
    let name: String
//    let relationship: RelationshipCategory
    let relationship: String
    let phone: String
    let email: String
    let imageName: String
    let imageURL: String
}

var familyMembers = [
    FamilyMember(
        name: "Bobby Deol",
        relationship: "Brother",
        phone: "8208457322",
        email: "contact@djdiptayan.in",
        imageName: "familyImg",
        imageURL:"https://as1.ftcdn.net/v2/jpg/02/99/04/20/1000_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg"
    ),
    FamilyMember(
        name: "Charlie Puth",
        relationship: "Son",
        phone: "8208457322",
        email: "contact@djdiptayan.in",
        imageName: "familyImg",
        imageURL:"https://as1.ftcdn.net/v2/jpg/02/99/04/20/1000_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg"
    ),
    FamilyMember(
        name: "Jack Puth",
        relationship: "Husband",
        phone: "8208457322",
        email: "contact@djdiptayan.in",
        imageName: "familyImg",
        imageURL:"https://as1.ftcdn.net/v2/jpg/02/99/04/20/1000_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg"
    ),
]
