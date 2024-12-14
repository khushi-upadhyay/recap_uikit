//
//  rapidMemory.swift
//  recap
//
//  Created by Diptayan Jash on 14/12/24.
//

import Foundation

// Question Model
struct rapiMemory: Codable, FireBaseDecodable {
    let id: String
    var text: String = ""
    var options: [String] = []
    var correctAnswer: String = ""
    var memoryType: MemoryType = .distant
    var EntityName: String = "rapidMemoryQuestions"
    
    
    init(id: String, fireData: Any) {
        self.id = id
        if let data = fireData as? [String: Any] {
            self.text = data["question"] as? String ?? ""
            self.options = data["options"] as? [String] ?? []
            self.correctAnswer = data["correctAnswer"] as? String ?? ""
            self.memoryType = MemoryType(rawValue: data["memoryType"] as? String ?? "") ?? .distant
            
        }
    }
}

// Memory Type Classification
enum MemoryType: String, Codable {
    case distant    // Long-term memories from years ago
    case immediate  // Very recent memories (minutes/hours)
    case remote     // Memories from weeks/months ago
    
    var description: String {
        switch self {
        case .distant:
            return "Long-term Memory"
        case .immediate:
            return "Short-term Memory"
        case .remote:
            return "Recent Memory"
        }
    }
}

// Memory Assessment Result
struct MemoryAssessment {
    let totalScore: Int
    let totalQuestions: Int
    let typeScores: [MemoryType: (correct: Int, total: Int)]
    
    var overallPercentage: Double {
        return Double(totalScore) / Double(totalQuestions) * 100
    }
    
    func percentageFor(type: MemoryType) -> Double {
        guard let score = typeScores[type] else { return 0 }
        return Double(score.correct) / Double(score.total) * 100
    }
    
    var status: String {
        switch overallPercentage {
        case 80...100:
            return "Excellent memory function"
        case 60..<80:
            return "Good memory function"
        case 40..<60:
            return "Memory function needs attention"
        default:
            return "Memory function needs improvement"
        }
    }
    
    var recommendations: [String] {
        var recommendations: [String] = []
        
        // Add type-specific recommendations
        for (type, score) in typeScores {
            let percentage = Double(score.correct) / Double(score.total) * 100
            if percentage < 60 {
                switch type {
                case .distant:
                    recommendations.append("Practice recalling old memories through photos or journaling")
                case .immediate:
                    recommendations.append("Try memory games or puzzles for short-term recall")
                case .remote:
                    recommendations.append("Keep a daily journal to strengthen recent memory")
                }
            }
        }
        
        // Add general recommendations
        recommendations.append(contentsOf: [
            "Maintain a regular sleep schedule",
            "Stay physically active",
            "Engage in social activities"
        ])
        
        return recommendations
    }
}

struct RapidMemoryQuiz {
    static func evaluateMemory(answers: [String], questions: [rapiMemory]) -> MemoryAssessment {
        var totalScore = 0
        var typeScores: [MemoryType: (correct: Int, total: Int)] = [
            .distant: (0, 0),
            .immediate: (0, 0),
            .remote: (0, 0)
        ]
        
        // Calculate scores
        for (index, question) in questions.enumerated() {
            let isCorrect = answers[index] == question.correctAnswer
            if isCorrect {
                totalScore += 1
            }
            
            // Update type-specific scores
            var currentScore = typeScores[question.memoryType] ?? (0, 0)
            currentScore.total += 1
            if isCorrect {
                currentScore.correct += 1
            }
            typeScores[question.memoryType] = currentScore
        }
        
        return MemoryAssessment(
            totalScore: totalScore,
            totalQuestions: questions.count,
            typeScores: typeScores
        )
    }
}
