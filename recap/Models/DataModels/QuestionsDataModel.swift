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
    var isAnswered: Bool
}

let questionsDemo: [Question] = [
    // Immediate Memory - Daily Routine
    Question(
        text: "Did you take your morning medication today?",
        category: .immediateMemory,
        subcategory: .dailyRoutine,
        tag: "Medication",
        answerOptions: [
            "Yes, I took it this morning.",
            "No, I forgot.",
            "I don't take any medication.",
            "I took it in the afternoon.",
            "I took it last night.",
            "I don't remember"
        ],
        isAnswered: false
    ),
    Question(text: "What did you eat for breakfast this morning?", category: .immediateMemory, subcategory: .dailyRoutine, tag: "Eating", answerOptions: ["Toast and eggs", "Cereal", "Fruit", "Pancakes", "I skipped breakfast", "I don't remember"],isAnswered: false
),
    Question(text: "Did you brush your teeth after waking up today?", category: .immediateMemory, subcategory: .dailyRoutine, tag: "Self-care", answerOptions: ["Yes", "No", "I brushed after lunch", "I brushed at night", "I don't remember"], isAnswered: false
),
    Question(text: "Did you have your afternoon snacks today?", category: .immediateMemory, subcategory: .dailyRoutine, tag: "Eating", answerOptions: ["Yes", "No", "I had fruit", "I had chips", "I don't snack", "I don't remember"], isAnswered: false
),
    Question(text: "Have you changed into your nightwear?", category: .immediateMemory, subcategory: .dailyRoutine, tag: "Self-care", answerOptions: ["Yes", "No", "I wear nightwear during the day", "I wear comfortable clothes", "I haven't yet", "I don't remember"], isAnswered: false
),
    Question(text: "What time did you wake up today?", category: .immediateMemory, subcategory: .dailyRoutine, tag: "Sleep/Wake", answerOptions: ["7:00 AM", "7:30 AM", "8:00 AM", "6:30 AM", "I woke up late", "I don't remember"], isAnswered: false
),
    Question(text: "Did you listen to music this afternoon?", category: .immediateMemory, subcategory: .dailyRoutine, tag: "Music", answerOptions: ["Yes", "No", "I listened to a podcast", "I listened to a radio station", "I don't remember"], isAnswered: false
),
    Question(text: "Did you take your afternoon medication?", category: .immediateMemory, subcategory: .dailyRoutine, tag: "Medication", answerOptions: ["Yes", "No", "I don't take medication", "I take it at night", "I take it in the morning", "I don't remember"], isAnswered: false
),

    // Immediate Memory - General
    Question(text: "What song did you last listen to today?", category: .immediateMemory, subcategory: .general, tag: "Music", answerOptions: ["Shape of You", "Blinding Lights", "Someone Like You", "Stay", "Levitating", "I don't remember"], isAnswered: false
),
    Question(text: "Did you say your morning prayer?", category: .immediateMemory, subcategory: .general, tag: "Spiritual/Religion", answerOptions: ["Yes", "No", "I meditate instead", "I prayed last night", "I don't pray", "I don't remember"], isAnswered: false
),
    Question(text: "Have you spoken to any of your family members today?", category: .immediateMemory, subcategory: .general, tag: "Social", answerOptions: ["Yes", "No", "I texted them", "I called them", "I saw them", "I don't remember"], isAnswered: false
),
    Question(text: "What movie did you watch this afternoon?", category: .immediateMemory, subcategory: .general, tag: "Movies", answerOptions: ["Inception", "The Dark Knight", "Titanic", "Avatar", "I didn't watch any movies", "I don't remember"], isAnswered: false
),
    Question(text: "Did you prepare your own food today?", category: .immediateMemory, subcategory: .general, tag: "Kitchen Management", answerOptions: ["Yes", "No", "I ordered food", "I made a snack", "I cooked for someone else", "I don't remember"],isAnswered: false
),

    // Recent Memory - Daily Routine
    Question(text: "What did you eat for dinner yesterday?", category: .recentMemory, subcategory: .dailyRoutine, tag: "Eating", answerOptions: ["Pizza", "Pasta", "Salad", "Rice and curry", "I don't remember"], isAnswered: false),
    Question(text: "Did you take your medication yesterday afternoon?", category: .recentMemory, subcategory: .dailyRoutine, tag: "Medication", answerOptions: ["Yes", "No", "I don't take medication", "I take it in the morning", "I don't remember"],isAnswered: false
),
    Question(text: "Did you go for a walk this week?", category: .recentMemory, subcategory: .dailyRoutine, tag: "Mobility", answerOptions: ["Yes", "No", "I walked yesterday", "I walked today", "I don't remember"],isAnswered: false
),
    Question(text: "Have you visited the temple or a religious place this week?", category: .recentMemory, subcategory: .dailyRoutine, tag: "Spiritual/Religion", answerOptions: ["Yes", "No", "I visited last week", "I don't go to temples", "I don't remember"],isAnswered: false
),
    Question(text: "Did you cook anything special for lunch in the last two days?", category: .recentMemory, subcategory: .dailyRoutine, tag: "Kitchen Management", answerOptions: ["Yes", "No", "I ordered food", "I made a sandwich", "I don't remember"],isAnswered: false
),
    Question(text: "How many times did you go out for a drive this week?", category: .recentMemory, subcategory: .dailyRoutine, tag: "Mobility/Driving", answerOptions: ["Once", "Twice", "Three times", "I didn't drive", "I don't remember"],isAnswered: false
),
    Question(text: "Did you sleep well last night?", category: .recentMemory, subcategory: .dailyRoutine, tag: "Sleep", answerOptions: ["Yes", "No", "I slept late", "I woke up multiple times", "I don't remember"],isAnswered: false
),
    Question(text: "Did you visit any friends or family this week?", category: .recentMemory, subcategory: .dailyRoutine, tag: "Social", answerOptions: ["Yes", "No", "I visited last week", "I saw them yesterday", "I don't remember"],isAnswered: false
),

    // Recent Memory - General
    Question(text: "Did you watch any religious program on TV this week?", category: .recentMemory, subcategory: .general, tag: "Spiritual/Religion", answerOptions: ["Yes", "No", "I watched a movie", "I listened to a podcast", "I don't remember"],isAnswered: false
),
    Question(text: "Have you seen any recent movie or television show this week?", category: .recentMemory, subcategory: .general, tag: "Movies", answerOptions: ["Yes", "No", "I watched a series", "I watched an episode", "I don't remember"],isAnswered: false
),
    Question(text: "What special prayers have you performed recently?", category: .recentMemory, subcategory: .general, tag: "Spiritual/Religion", answerOptions: ["Morning prayer", "Evening prayer", "I don't perform prayers", "I don't remember", "I don't remember"],isAnswered: false
),
    Question(text: "Have you been to any cultural or religious festivals recently?", category: .recentMemory, subcategory: .general, tag: "Culture/Festival", answerOptions: ["Yes", "No", "I went last month", "I don't attend festivals", "I don't remember"],isAnswered: false
),
    Question(text: "Did you listen to devotional music this week?", category: .recentMemory, subcategory: .general, tag: "Music", answerOptions: ["Yes", "No", "I listened to a religious podcast", "I listened to music yesterday", "I don't remember"],isAnswered: false
),

    // Remote Memory - Daily Routine
    Question(text: "How did you usually spend your mornings when you were younger?", category: .remoteMemory, subcategory: .dailyRoutine, tag: "Self-care", answerOptions: ["Exercise", "Meditation", "Reading", "Sleeping in", "I don't remember"],isAnswered: false
),
    Question(text: "What was your favorite food when you were in your 30s?", category: .remoteMemory, subcategory: .dailyRoutine, tag: "Eating", answerOptions: ["Pizza", "Burgers", "Pasta", "Sandwiches", "I don't remember"],isAnswered: false
),
    Question(text: "Did you enjoy driving when you were younger?", category: .remoteMemory, subcategory: .dailyRoutine, tag: "Mobility/Driving", answerOptions: ["Yes", "No", "I didn't have a car", "I enjoyed long drives", "I don't remember"],isAnswered: false
),
    Question(text: "How did you manage household work, such as cooking, in your younger days?", category: .remoteMemory, subcategory: .dailyRoutine, tag: "Kitchen Management", answerOptions: ["I cooked often", "I cooked occasionally", "I didn't cook", "I had help at home", "I don't remember"],isAnswered: false
),
    Question(text: "What was your favorite time of the day for meditation or prayers?", category: .remoteMemory, subcategory: .dailyRoutine, tag: "Spiritual/Religion", answerOptions: ["Morning", "Evening", "Before bed", "After waking up", "I don't remember"],isAnswered: false
),

    // Remote Memory - General
    Question(text: "What sports did you play regularly when you were young?", category: .remoteMemory, subcategory: .general, tag: "Sports", answerOptions: ["Football", "Cricket", "Basketball", "Swimming", "I don't remember"],isAnswered: false
),
    Question(text: "What hobbies did you pursue in your younger years?", category: .remoteMemory, subcategory: .general, tag: "Hobbies", answerOptions: ["Reading", "Drawing", "Music", "Sports", "I don't remember"],isAnswered: false
),
    Question(text: "Have you traveled to any foreign countries in the past?", category: .remoteMemory, subcategory: .general, tag: "Travel", answerOptions: ["Yes", "No", "I traveled for work", "I traveled for vacation", "I don't remember"],isAnswered: false
),
    Question(text: "Do you remember your first job? What was it?", category: .remoteMemory, subcategory: .general, tag: "Career", answerOptions: ["Yes", "No", "I worked in a shop", "I worked in an office", "I don't remember"],isAnswered: false
),
    Question(text: "What language did you speak with your family when you were young?", category: .remoteMemory, subcategory: .general, tag: "Language", answerOptions: ["English", "Hindi", "Bengali", "Other", "I don't remember"],isAnswered: false
)
]
