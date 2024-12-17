import UIKit
import Firebase

class MemoryCheckViewController: UIViewController {
    
    // MARK: - UI Components
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    private let optionsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .heavy)
        button.isEnabled = false
        return button
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    // MARK: - Properties
    private var questions = [rapiMemory]()
    private var currentQuestionIndex = 0
    private var selectedAnswer: String?
    private var score = 0
    private var userAnswers: [String] = []
    var preloadedQuestions: [rapiMemory]?
    private var viewModel: MemoryViewModelProtocol?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MemoryViewModel()
        setupUI()

        if let preloadedQuestions = preloadedQuestions, !preloadedQuestions.isEmpty {
            self.questions = preloadedQuestions
            displayCurrentQuestion()
        } else {
            fetchQuestions()
        }
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Memory Check"
        
        [questionLabel, optionsStackView, submitButton, progressLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            optionsStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 40),
            optionsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            optionsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            submitButton.bottomAnchor.constraint(equalTo: progressLabel.topAnchor, constant: -20),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: 200),
            submitButton.heightAnchor.constraint(equalToConstant: 44),
            
            progressLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            progressLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Fetch Questions from Firebase
    private func fetchQuestions() {
        viewModel?.fetchQuestions(completion: { [weak self] result in
            switch result {
            case .success(let questions):
                DispatchQueue.main.async {
                    self?.questions = questions
                    self?.displayCurrentQuestion()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error",
                                                  message: "Failed to load questions: \(error.localizedDescription)",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(alert, animated: true)
                }
            }
        })
    }
    
    // MARK: - Display Current Question
    private func displayCurrentQuestion() {
        guard currentQuestionIndex < questions.count else {
            showResults()
            return
        }
        
        let question = questions[currentQuestionIndex]
        questionLabel.text = question.text
        
        // Clear previous options
        optionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Add option buttons
        question.options.forEach { option in
            let button = UIButton()
            button.setTitle(option, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .systemGray
            button.layer.cornerRadius = 8
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)  // Set bold text for options
            button.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
            optionsStackView.addArrangedSubview(button)
        }
        
        progressLabel.text = "Question \(currentQuestionIndex + 1) of \(questions.count)"
        submitButton.isEnabled = false
    }
    
    // MARK: - Actions
    @objc private func optionSelected(_ sender: UIButton) {
        optionsStackView.arrangedSubviews.forEach { ($0 as? UIButton)?.backgroundColor = .systemGray }
        sender.backgroundColor = .systemBlue
        selectedAnswer = sender.title(for: .normal)
        submitButton.isEnabled = true
    }
    
    @objc private func submitButtonTapped() {
        guard let selectedAnswer = selectedAnswer else { return }
        
        // Store the answer
        userAnswers.append(selectedAnswer)
        
        currentQuestionIndex += 1
        self.selectedAnswer = nil
        
        if currentQuestionIndex < questions.count {
            displayCurrentQuestion()
        } else {
            showResults()
        }
    }
    
    private func showResults() {
        let assessment = RapidMemoryQuiz.evaluateMemory(answers: userAnswers, questions: questions)
        
        var message = "Overall Score: \(assessment.totalScore) out of \(assessment.totalQuestions)\n\n"
        message += "Memory Type Breakdown:\n"
        
        for type in [MemoryType.immediate, .remote, .distant] {
            let percentage = assessment.percentageFor(type: type)
            message += "\(type.description): \(Int(percentage))%\n"
        }
        
        message += "\nStatus: \(assessment.status)\n\n"
        message += "Recommendations:\n"
        assessment.recommendations.forEach { message += "• \($0)\n" }
        
        let alertController = UIAlertController(
            title: "Memory Assessment Complete",
            message: message,
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        
        present(alertController, animated: true)
    }
}

#Preview{
    MemoryCheckViewController()
}
