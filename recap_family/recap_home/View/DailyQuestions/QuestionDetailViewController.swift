
//
//import UIKit
//
//class QuestionDetailViewController: UIViewController {
//

import UIKit

class QuestionDetailViewController: UIViewController {

    
    var question: Question?
    var selectedOptionButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        setupUI()
    }

    // UI Components
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let questionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let optionsContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let footerLabel: UILabel = {
        let label = UILabel()
        label.text = "Keep going — each one sharpens your mind and warms hearts!"
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // UI Setup
    private func setupUI() {
        guard let question = question else { return }

        // Add subviews
        view.addSubview(questionLabel)
        if let imageName = question.image {
            questionImageView.image = UIImage(named: imageName)
            view.addSubview(questionImageView)
        }
        view.addSubview(optionsContainer)
        view.addSubview(submitButton)
        view.addSubview(footerLabel)

        // Set question text
        questionLabel.text = question.title

        // Create option buttons in rows of 2
        for (index, option) in question.options.enumerated() {
            if index % 2 == 0 {
                let horizontalStack = UIStackView()
                horizontalStack.axis = .horizontal
                horizontalStack.spacing = 16
                horizontalStack.distribution = .fillEqually
                horizontalStack.translatesAutoresizingMaskIntoConstraints = false
                optionsContainer.addArrangedSubview(horizontalStack)
            }
            let button = createOptionButton(with: option)
            button.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside) // Add target to track selection
            (optionsContainer.arrangedSubviews.last as? UIStackView)?.addArrangedSubview(button)
        }

        // Setup constraints
        setupConstraints()
        
        // Add submit button target
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    }

    // Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        if question?.image != nil {
            NSLayoutConstraint.activate([
                questionImageView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20),
                questionImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                questionImageView.widthAnchor.constraint(equalToConstant: 150),
                questionImageView.heightAnchor.constraint(equalToConstant: 150),

                optionsContainer.topAnchor.constraint(equalTo: questionImageView.bottomAnchor, constant: 20)
            ])
        } else {
            NSLayoutConstraint.activate([
                optionsContainer.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20)
            ])
        }

        NSLayoutConstraint.activate([
            optionsContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            optionsContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            submitButton.topAnchor.constraint(equalTo: optionsContainer.bottomAnchor, constant: 30),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: 120),
            submitButton.heightAnchor.constraint(equalToConstant: 50),

            footerLabel.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 20),
            footerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            footerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    // Create Option Button
    private func createOptionButton(with title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }

    // Option Selection Action
//    @objc private func optionSelected(_ sender: UIButton) {
//        // Track the selected button
//        selectedOptionButton?.layer.borderColor = UIColor.lightGray.cgColor // Reset previous selection
//        selectedOptionButton = sender
//        sender.layer.borderColor = UIColor.systemBlue.cgColor // Highlight selected option
//    }
//
    
    
    @objc private func optionSelected(_ sender: UIButton) {
        // Reset the previously selected button's appearance
        selectedOptionButton?.layer.borderColor = UIColor.lightGray.cgColor
        selectedOptionButton?.backgroundColor = .white

        // Update the selected button's appearance
        selectedOptionButton = sender
        sender.layer.borderColor = UIColor.systemBlue.cgColor
        sender.backgroundColor = UIColor(red: 0.9, green: 0.95, blue: 1.0, alpha: 1.0) // Very light blue color
    }
    
    
    // Submit Button Action
    @objc private func submitButtonTapped() {
        // Check if an option is selected
        guard selectedOptionButton != nil else {
            // Optionally, alert the user to select an option first
            return
        }
        
        // Change the submit button color to green
        submitButton.backgroundColor = .systemGreen
        submitButton.setTitle("Submitted", for: .normal)
    }
}
