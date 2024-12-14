//
//  QuestionCell.swift
//  recap
//
//  Created by Diptayan Jash on 18/11/24.
//

import Foundation
import UIKit
class AnswerViewController: UIViewController {
    
    var onAnswerSubmitted: (() -> Void)?

    private var question: Question
    
    private let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(dismissView))
    }
    @objc private func dismissView() {
        dismiss(animated: true, completion: nil)
    }

    private let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()

    private lazy var optionsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()

    private let submitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = .systemGray5
        button.setTitleColor(.systemGray, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        return button
    }()

    private let quoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Keep going — each one sharpens your mind and warms hearts!"
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()

    private var selectedButton: UIButton?

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(question: Question) {
        self.question = question
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = view.bounds
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Answer"
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(questionLabel)
        contentView.addSubview(optionsStackView)
        contentView.addSubview(submitButton)
        contentView.addSubview(quoteLabel)

        questionLabel.text = question.text

        let options = question.answerOptions
        options.forEach { option in
            let button = createOptionButton(with: option)
            optionsStackView.addArrangedSubview(button)
        }

        submitButton.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
    }

    private func createOptionButton(with title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray5.cgColor
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(optionButtonTapped(_:)), for: .touchUpInside)
        return button
    }

    @objc private func optionButtonTapped(_ sender: UIButton) {
        selectedButton?.backgroundColor = .white
        selectedButton?.layer.borderColor = UIColor.systemGray5.cgColor

        sender.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        sender.layer.borderColor = UIColor.systemBlue.cgColor
        selectedButton = sender

        submitButton.backgroundColor = .systemBlue
        submitButton.setTitleColor(.white, for: .normal)
    }

    @objc private func didTapSubmit() {
        print("Selected Ans:" , selectedButton?.titleLabel?.text ?? "")
        print(question.isAnswered)
        guard selectedButton != nil else {
            let alert = UIAlertController(
                title: "No Selection",
                message: "Please select an answer before submitting",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        question.isAnswered = true
        print(question.isAnswered)
        let alert = UIAlertController(
            title: "Great Work, Keep Going!!",
            message: "Studies show that consistent mental exercises can improve cognitive function by up to 20%",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { [weak self] _ in
            self?.onAnswerSubmitted?()
            self?.dismiss(animated: true, completion: nil)
        }))

        present(alert, animated: true)
    }
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            questionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            optionsStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 30),
            optionsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            optionsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),

            submitButton.topAnchor.constraint(equalTo: optionsStackView.bottomAnchor, constant: 30),
            submitButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            submitButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            submitButton.heightAnchor.constraint(equalToConstant: 50),

            quoteLabel.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 20),
            quoteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            quoteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            quoteLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
