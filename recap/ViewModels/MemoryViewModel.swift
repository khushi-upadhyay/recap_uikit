//
//  Untitled.swift
//  recap
//
//  Created by Diptayan Jash on 14/12/24.
//

protocol MemoryViewModelProtocol {
    func fetchQuestions(completion: @escaping (Result<[rapiMemory], Error>) -> Void)
}

class MemoryViewModel: MemoryViewModelProtocol {
    var dataFetchManager: DataFetchProtocol
    
    init(dataFetchManager: DataFetchProtocol = DataFetch()) {
        self.dataFetchManager = dataFetchManager
    }
        
    func fetchQuestions(completion: @escaping (Result<[rapiMemory], Error>) -> Void) {
    
        
        self.dataFetchManager.fetchRapidQuestions { [weak self] questions, error in
            if let error = error {
                print("Error fetching questions: \(error.localizedDescription)")
              completion(.failure(error))
                
            }
            
            guard let questions = questions, !questions.isEmpty else {
                print("No questions received from Firebase")
                return
            }
            
            print("Successfully fetched \(questions.count) questions")
            completion(.success(questions))
        }
    }
}
