import UIKit

class GeoSorterViewController: UIViewController {
    private let categories = ["City", "State", "Country"]
    private var locations = [
        "City": ["Paris", "Tokyo", "Mumbai", "New York", "Sydney"],
        "State": ["California", "Texas", "Florida", "Gujarat", "Victoria"],
        "Country": ["France", "Japan", "India", "USA", "Australia"]
    ]
    
    private var score = 0
    private var answeredWords: [String: String] = [:]

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        label.numberOfLines = 0
        label.text = "Place the City, State and Country in correct group"
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .systemIndigo
        label.text = "Score: 0"
        return label
    }()
    
    private lazy var categoryStacks: [CategoryStackView] = categories.map { category in
        let stackView = CategoryStackView(title: category)
        return stackView
    }
    
    private let wordsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let wordsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Word Game"
        view.backgroundColor = .systemBackground
        setupGradientBackground()
        setupUI()
        populateWords()
    }
    
    private func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.systemTeal.withAlphaComponent(0.1).cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupUI() {
        [scoreLabel, wordsContainer].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        wordsContainer.addSubview(wordsStackView)
        wordsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let categoriesStack = UIStackView(arrangedSubviews: categoryStacks)
        categoriesStack.axis = .horizontal
        categoriesStack.distribution = .fillEqually
        categoriesStack.spacing = 20
        categoriesStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(categoriesStack)
        view.addSubview(subtitleLabel)
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            scoreLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16),
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            categoriesStack.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 20),
            categoriesStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoriesStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            categoriesStack.heightAnchor.constraint(equalToConstant: 200),
            
            wordsContainer.topAnchor.constraint(equalTo: categoriesStack.bottomAnchor, constant: 20),
            wordsContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            wordsContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            wordsContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            wordsStackView.topAnchor.constraint(equalTo: wordsContainer.topAnchor, constant: 16),
            wordsStackView.leadingAnchor.constraint(equalTo: wordsContainer.leadingAnchor, constant: 16),
            wordsStackView.trailingAnchor.constraint(equalTo: wordsContainer.trailingAnchor, constant: -16),
            wordsStackView.bottomAnchor.constraint(equalTo: wordsContainer.bottomAnchor, constant: -16)
        ])
    }
    
    private func populateWords() {
        wordsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let rowStack1 = createHorizontalWordStack()
        let rowStack2 = createHorizontalWordStack()
        let rowStack3 = createHorizontalWordStack()
        
        wordsStackView.addArrangedSubview(rowStack1)
        wordsStackView.addArrangedSubview(rowStack2)
        wordsStackView.addArrangedSubview(rowStack3)
        
        var allWords: [(word: String, category: String)] = []
        for (category, words) in locations {
            words.forEach { allWords.append(($0, category)) }
        }
        allWords.shuffle()
        
        let wordsPerRow = 4
        for (index, wordInfo) in allWords.enumerated() {
            let row = index / wordsPerRow
            let wordLabel = createWordLabel(for: wordInfo.word, category: wordInfo.category)
            
            wordLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
            
            switch row {
            case 0: rowStack1.addArrangedSubview(wordLabel)
            case 1: rowStack2.addArrangedSubview(wordLabel)
            case 2: rowStack3.addArrangedSubview(wordLabel)
            default: break
            }
        }
    }
    
    private func createHorizontalWordStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillProportionally
        stack.alignment = .center
    
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        
        return stack
    }
    
    private func createWordLabel(for word: String, category: String) -> UILabel {
        let label = UILabel()
        label.text = word
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.backgroundColor = .systemIndigo.withAlphaComponent(0.1)
        label.layer.cornerRadius = 12
        label.layer.borderWidth = 1.5
        label.layer.borderColor = UIColor.systemIndigo.cgColor
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = true
        label.tag = category.hashValue
        
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 1
        
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        label.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
        
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(wordTapped(_:)))
        label.addGestureRecognizer(tap)
        return label
    }
    
    @objc private func wordTapped(_ sender: UITapGestureRecognizer) {
        guard let label = sender.view as? UILabel,
              let word = label.text else { return }
        
        let correctCategory = categories.first { $0.hashValue == label.tag } ?? ""
        presentCategoryChoice(for: word, correctCategory: correctCategory, label: label)
    }
    
    private func presentCategoryChoice(for word: String, correctCategory: String, label: UILabel) {
        let alert = UIAlertController(
            title: "Where does \(word) belong?",
            message: "Select the correct category",
            preferredStyle: .alert
        )
        
        for category in categories {
            let action = UIAlertAction(title: category, style: .default) { [weak self] _ in
                self?.checkAnswer(word: word, chosenCategory: category, correctCategory: correctCategory, label: label)
            }
            alert.addAction(action)
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func checkAnswer(word: String, chosenCategory: String, correctCategory: String, label: UILabel) {
        answeredWords[word] = chosenCategory
        let isCorrect = chosenCategory == correctCategory
        
        if isCorrect {
            score += 10
            scoreLabel.text = "Score: \(score)"
            
            if let categoryStack = categoryStacks.first(where: { $0.category == correctCategory }) {
                let finalFrame = categoryStack.containerView.convert(categoryStack.containerView.bounds, to: view)
                
                let animatingLabel = UILabel(frame: label.convert(label.bounds, to: view))
                animatingLabel.text = word
                animatingLabel.font = label.font
                animatingLabel.textAlignment = .center
                animatingLabel.backgroundColor = label.backgroundColor
                animatingLabel.layer.cornerRadius = label.layer.cornerRadius
                animatingLabel.layer.masksToBounds = true
                view.addSubview(animatingLabel)
                
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                    animatingLabel.frame = CGRect(
                        x: finalFrame.midX - 50,
                        y: finalFrame.minY + 10,
                        width: 100,
                        height: 40
                    )
                } completion: { _ in
                    // Remove the animating label
                    animatingLabel.removeFromSuperview()
                    // Add word to category stack
                    categoryStack.addWord(word)
                    
                    // Replace the word in the original position
                    self.replaceWord(at: label)
                }
                
                // Fade out the original label
                UIView.animate(withDuration: 0.3) {
                    label.alpha = 0
                } completion: { _ in
                    label.removeFromSuperview()
                }
                
            }
        } else {
            label.backgroundColor = .systemRed.withAlphaComponent(0.3)
            label.shake()
            
            // Reset background color after delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                UIView.animate(withDuration: 0.3) {
                    label.backgroundColor = .systemIndigo.withAlphaComponent(0.1)
                }
            }
        }
    }
    
    private func replaceWord(at label: UILabel) {
        // Get all unused words
        var unusedWords: [(word: String, category: String)] = []
        for (category, words) in locations {
            words.forEach { word in
                if answeredWords[word] == nil {
                    unusedWords.append((word, category))
                }
            }
        }
        
        // If there are unused words, randomly select one
        if let newWord = unusedWords.randomElement() {
            let newLabel = createWordLabel(for: newWord.word, category: newWord.category)
            
            // Get the stack view that contained the old label
            if let stackView = label.superview as? UIStackView {
                // Add new label with fade in animation
                newLabel.alpha = 0
                stackView.addArrangedSubview(newLabel)
                
                UIView.animate(withDuration: 0.3) {
                    newLabel.alpha = 1
                }
            }
        }
    }
    
    private func createCategoryContainer(title: String) -> UIView {
        let container = UIView()
        container.backgroundColor = .systemGray6
        container.layer.cornerRadius = 12
        container.layer.borderColor = UIColor.systemGray4.cgColor
        container.layer.borderWidth = 1

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .darkGray
        titleLabel.textAlignment = .center
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        
        // Add rows of empty labels to represent placeholders
        for _ in 0..<2 { // Two rows
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 8
            rowStack.distribution = .fillEqually
            for _ in 0..<4 { // Four columns
                let placeholderLabel = UILabel()
                placeholderLabel.backgroundColor = .white
                placeholderLabel.layer.cornerRadius = 8
                placeholderLabel.clipsToBounds = true
                rowStack.addArrangedSubview(placeholderLabel)
            }
            stackView.addArrangedSubview(rowStack)
        }

        // Layout
        container.addSubview(titleLabel)
        container.addSubview(stackView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8)
        ])
        
        return container
    }
}

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.4
        animation.values = [-10.0, 10.0, -10.0, 10.0, -5.0, 5.0, -2.5, 2.5, 0.0]
        layer.add(animation, forKey: "shake")
    }
}

#Preview(){
    GeoSorterViewController()
}
