import Foundation

struct UserDetails: FireBaseDecodable {
    var firstName: String
    var lastName: String
    var dateOfBirth: String
    var sex: String
    var bloodGroup: String
    var stage: String
    var profileImageURL: String?
    
    // Default initializer
    init(firstName: String = "",
         lastName: String = "",
         dateOfBirth: String = "",
         sex: String = "",
         bloodGroup: String = "",
         stage: String = "",
         profileImageURL: String? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.sex = sex
        self.bloodGroup = bloodGroup
        self.stage = stage
        self.profileImageURL = profileImageURL
    }
    
    // FirebaseDecodable initializer
    init(id: String, fireData: Any) {
        if let data = fireData as? [String: Any] {
            firstName = data["firstName"] as? String ?? ""
            lastName = data["lastName"] as? String ?? ""
            dateOfBirth = data["dateOfBirth"] as? String ?? ""
            sex = data["sex"] as? String ?? ""
            bloodGroup = data["bloodGroup"] as? String ?? ""
            stage = data["stage"] as? String ?? ""
            profileImageURL = data["profileImageURL"] as? String
        } else {
            firstName = ""
            lastName = ""
            dateOfBirth = ""
            sex = ""
            bloodGroup = ""
            stage = ""
            profileImageURL = nil
        }
    }
}


enum SexOptions: String, Codable, CaseIterable {
    case Male
    case Female
    case Other
}

enum BloodGroupOptions: String, Codable, CaseIterable {
    case APlus = "A+"
    case AMinus = "A-"
    case BPlus = "B+"
    case BMinus = "B-"
    case OPlus = "O+"
    case OMinus = "O-"
    case ABPlus = "AB+"
    case ABMinus = "AB-"
}

enum StageOptions: String, Codable, CaseIterable {
    case Early
    case Middle
    case Advanced
}
