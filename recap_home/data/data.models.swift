import Foundation

// Enum for questions
enum QuestionCategory: String, Codable {
    case immediateMemory
    case recentMemory
    case remoteMemory
}

// Enum for subcategories of questions
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
}

// Family Member Model
struct FamilyMember: Identifiable, Codable {
    var id = UUID()
    var name: String
    var relationship: String
    var phone: String
    var imageName: String
//    var preferredCheckInTimes: [String]
//    var recentConversations: [String]
}

// Patient Model
struct Patient: Identifiable, Codable {
    var id = UUID()
    var name: String
    var age: Int
    var medicalCondition: String
//    var dailyMedications: [String]
//    var dietaryRestrictions: [String]
    var dailyRoutineReminders: [Question]
    var memoryAssessmentQuestions: [Question]
    var familyConnections: [FamilyMember]
//    var preferredMusic: [String]
}

let extendedSampleQuestions: [Question] = [
    // Immediate Memory - Daily Routine
    Question(text: "Did you take your morning medication today?", category: .immediateMemory, subcategory: .dailyRoutine, tag: "Medication"),
    Question(text: "What did you eat for breakfast this morning?", category: .immediateMemory, subcategory: .dailyRoutine, tag: "Eating"),
    Question(text: "Did you brush your teeth after waking up today?", category: .immediateMemory, subcategory: .dailyRoutine, tag: "Self-care"),
    Question(text: "Did you have your afternoon snacks today?", category: .immediateMemory, subcategory: .dailyRoutine, tag: "Eating"),
    Question(text: "Have you changed into your nightwear?", category: .immediateMemory, subcategory: .dailyRoutine, tag: "Self-care"),
    Question(text: "What time did you wake up today?", category: .immediateMemory, subcategory: .dailyRoutine, tag: "Sleep/Wake"),
    Question(text: "Did you listen to music this afternoon?", category: .immediateMemory, subcategory: .dailyRoutine, tag: "Music"),
    Question(text: "Did you take your afternoon medication?", category: .immediateMemory, subcategory: .dailyRoutine, tag: "Medication"),
    
    // Immediate Memory - General
    Question(text: "What song did you last listen to today?", category: .immediateMemory, subcategory: .general, tag: "Music"),
    Question(text: "Did you say your morning prayer?", category: .immediateMemory, subcategory: .general, tag: "Spiritual/Religion"),
    Question(text: "Have you spoken to any of your family members today?", category: .immediateMemory, subcategory: .general, tag: "Social"),
    Question(text: "What movie did you watch this afternoon?", category: .immediateMemory, subcategory: .general, tag: "Movies"),
    Question(text: "Did you prepare your own food today?", category: .immediateMemory, subcategory: .general, tag: "Kitchen Management"),
    
    // Recent Memory - Daily Routine
    Question(text: "What did you eat for dinner yesterday?", category: .recentMemory, subcategory: .dailyRoutine, tag: "Eating"),
    Question(text: "Did you take your medication yesterday afternoon?", category: .recentMemory, subcategory: .dailyRoutine, tag: "Medication"),
    Question(text: "Did you go for a walk this week?", category: .recentMemory, subcategory: .dailyRoutine, tag: "Mobility"),
    Question(text: "Have you visited the temple or a religious place this week?", category: .recentMemory, subcategory: .dailyRoutine, tag: "Spiritual/Religion"),
    Question(text: "Did you cook anything special for lunch in the last two days?", category: .recentMemory, subcategory: .dailyRoutine, tag: "Kitchen Management"),
    Question(text: "How many times did you go out for a drive this week?", category: .recentMemory, subcategory: .dailyRoutine, tag: "Mobility/Driving"),
    Question(text: "Did you sleep well last night?", category: .recentMemory, subcategory: .dailyRoutine, tag: "Sleep"),
    Question(text: "Did you visit any friends or family this week?", category: .recentMemory, subcategory: .dailyRoutine, tag: "Social"),
    
    // Recent Memory - General
    Question(text: "Did you watch any religious program on TV this week?", category: .recentMemory, subcategory: .general, tag: "Spiritual/Religion"),
    Question(text: "Have you seen any recent movie or television show this week?", category: .recentMemory, subcategory: .general, tag: "Movies"),
    Question(text: "What special prayers have you performed recently?", category: .recentMemory, subcategory: .general, tag: "Spiritual/Religion"),
    Question(text: "Have you been to any cultural or religious festivals recently?", category: .recentMemory, subcategory: .general, tag: "Culture/Festival"),
    Question(text: "Did you listen to devotional music this week?", category: .recentMemory, subcategory: .general, tag: "Music"),
    
    // Remote Memory - Daily Routine
    Question(text: "How did you usually spend your mornings when you were younger?", category: .remoteMemory, subcategory: .dailyRoutine, tag: "Self-care"),
    Question(text: "What was your favorite food when you were in your 30s?", category: .remoteMemory, subcategory: .dailyRoutine, tag: "Eating"),
    Question(text: "Did you enjoy driving when you were younger?", category: .remoteMemory, subcategory: .dailyRoutine, tag: "Mobility/Driving"),
    Question(text: "How did you manage household work, such as cooking, in your younger days?", category: .remoteMemory, subcategory: .dailyRoutine, tag: "Kitchen Management"),
    Question(text: "What was your favorite time of the day for meditation or prayers?", category: .remoteMemory, subcategory: .dailyRoutine, tag: "Spiritual/Religion"),
    Question(text: "Did you always go for evening walks?", category: .remoteMemory, subcategory: .dailyRoutine, tag: "Mobility"),
    
    // Remote Memory - General
    Question(text: "What was your favorite religious festival growing up?", category: .remoteMemory, subcategory: .general, tag: "Spiritual/Religion"),
    Question(text: "Can you recall your favorite movies from the past?", category: .remoteMemory, subcategory: .general, tag: "Movies"),
    Question(text: "What devotional songs did you listen to in your youth?", category: .remoteMemory, subcategory: .general, tag: "Music"),
    Question(text: "What interests or hobbies did you have when you were younger?", category: .remoteMemory, subcategory: .general, tag: "Interests"),
    Question(text: "What was your preferred style of dressing when you were in your 40s?", category: .remoteMemory, subcategory: .general, tag: "Self-care"),
    
    // Health - Immediate
    Question(text: "Did you take your blood pressure medication today?", category: .immediateMemory, subcategory: .health, tag: "Medication"),
    Question(text: "Have you taken any pain relief medication this morning?", category: .immediateMemory, subcategory: .health, tag: "Medication"),
    Question(text: "Did you check your blood sugar this morning?", category: .immediateMemory, subcategory: .health, tag: "Health Check"),
    
    // Health - Remote
    Question(text: "Can you recall when you first started taking medication for your health?", category: .remoteMemory, subcategory: .health, tag: "Health History"),
    Question(text: "What was your first major health-related surgery or treatment?", category: .remoteMemory, subcategory: .health, tag: "Health History"),
    Question(text: "Did you experience any health issues in your youth?", category: .remoteMemory, subcategory: .health, tag: "Health History"),
    
    // Spiritual and Religious Practices - Remote Memory
    Question(text: "Can you remember your first visit to a major pilgrimage site in India?", category: .remoteMemory, subcategory: .spiritual, tag: "Spiritual/Religion"),
    Question(text: "How did your family celebrate festivals in a traditional manner during your childhood?", category: .remoteMemory, subcategory: .spiritual, tag: "Culture/Festival"),
    Question(text: "What religious rituals did your grandparents teach you as a child?", category: .remoteMemory, subcategory: .spiritual, tag: "Spiritual/Religion"),
    
    // Family and Social Life - Remote Memory
    Question(text: "How did you celebrate your wedding anniversary when you were younger?", category: .remoteMemory, subcategory: .family, tag: "Family"),
    Question(text: "What was your favorite memory of your children growing up?", category: .remoteMemory, subcategory: .family, tag: "Family"),
    Question(text: "Can you recall the first time you held your grandchild?", category: .remoteMemory, subcategory: .family, tag: "Family"),
    Question(text: "What was your family’s favorite activity on weekends when your children were small?", category: .remoteMemory, subcategory: .family, tag: "Family"),
    
    // Music, Movies, and Hobbies - Immediate
    Question(text: "Did you listen to any classical music today?", category: .immediateMemory, subcategory: .musicMovies, tag: "Music"),
    Question(text: "Did you watch any new movies this week?", category: .immediateMemory, subcategory: .musicMovies, tag: "Movies"),
    
    // Hobbies - Remote Memory
    Question(text: "What was your favorite hobby as a child?", category: .remoteMemory, subcategory: .hobbies, tag: "Hobbies"),
    Question(text: "Did you participate in any singing or dancing competitions in your youth?", category: .remoteMemory, subcategory: .hobbies, tag: "Hobbies"),
    Question(text: "What was your favorite sport or outdoor activity as a child?", category: .remoteMemory, subcategory: .hobbies, tag: "Hobbies"),
]

// Example patient
let examplePatient = Patient(
    name: "John Doe",
    age: 72,
    medicalCondition: "Alzheimer's",
//    dailyMedications: ["Aspirin", "Vitamin D"],
//    dietaryRestrictions: ["Low sodium", "No dairy"],
    dailyRoutineReminders: extendedSampleQuestions.filter { $0.subcategory == .dailyRoutine },
    memoryAssessmentQuestions: extendedSampleQuestions.filter { $0.category != .immediateMemory },
    // Example Family Members
    familyConnections: [
        FamilyMember(name: "Bobby Deol", relationship: "Daughter", phone: "989878778", imageName: "bobby"),
        FamilyMember(name: "Charlie Puth", relationship: "Son", phone: "989878778", imageName: "charlie"),
        FamilyMember(name: "Jack Puth", relationship: "Husband", phone: "989878778", imageName: "jack"),
        FamilyMember(name: "John Deol", relationship: "Grandson", phone: "989878778", imageName: "john")
    ]
//    preferredMusic: ["Classical", "Bhajans"]
)
