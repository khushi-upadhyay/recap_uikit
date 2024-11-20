//
//  OnboardingViewController.swift
//  recap_home
//
//  Created by user@47 on 13/11/24.
//

//
//  OnboardingViewController.swift
//  recap_home
//
//  Created by user@47 on 13/11/24.
//

//
//  OnboardingViewController.swift
//  recap_home
//
//  Created by user@47 on 13/11/24.
//

import UIKit

class OnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()
        setupCardUI()
    }

    private func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.69, green: 0.88, blue: 0.88, alpha: 1.0).cgColor,
            UIColor(red: 0.94, green: 0.74, blue: 0.80, alpha: 1.0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func setupCardUI() {
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 20
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 5)
        cardView.layer.shadowRadius = 10
        cardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cardView)

        let titleLabel = UILabel()
        titleLabel.text = "Get Started with Recap"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(titleLabel)

        let featuresStackView = UIStackView()
        featuresStackView.axis = .vertical
        featuresStackView.spacing = 20
        featuresStackView.translatesAutoresizingMaskIntoConstraints = false

        let features = [
            ("Progress", "Track daily, weekly and monthly progress.", "chart.line.uptrend.xyaxis"),
            ("Articles", "View articles related to Alzheimer's to stay updated.", "doc.text"),
            ("Daily Questions", "Ask related questions at intervals.", "bubble.left.and.bubble.right"),
            ("Cross Verification", "Answers are double-checked with the family.", "checkmark.circle")
        ]

        for (title, description, systemIconName) in features {
            let featureView = createFeatureView(title: title, description: description, systemIconName: systemIconName)
            featuresStackView.addArrangedSubview(featureView)
        }

        cardView.addSubview(featuresStackView)

        let continueButton = UIButton(type: .system)
        continueButton.setTitle("Continue", for: .normal)
        continueButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        continueButton.backgroundColor = UIColor(red: 93/255, green: 156/255, blue: 236/255, alpha: 1.0)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.layer.cornerRadius = 20
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.addTarget(self, action: #selector(navigateToSections), for: .touchUpInside)
        cardView.addSubview(continueButton)

        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),

            featuresStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            featuresStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            featuresStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),

            continueButton.topAnchor.constraint(equalTo: featuresStackView.bottomAnchor, constant: 30),
            continueButton.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: 200),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20)
        ])
    }

    private func createFeatureView(title: String, description: String, systemIconName: String) -> UIStackView {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(systemName: systemIconName)
        iconImageView.tintColor = .systemBlue
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)

        let descriptionLabel = UILabel()
        descriptionLabel.text = description
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 0

        let textStack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        textStack.axis = .vertical
        textStack.spacing = 4

        let featureStack = UIStackView(arrangedSubviews: [iconImageView, textStack])
        featureStack.axis = .horizontal
        featureStack.alignment = .center
        featureStack.spacing = 12
        return featureStack
    }

    @objc private func navigateToSections() {
        if let navigationController = self.navigationController {
            let sectionsVC = SectionsViewController()
            navigationController.pushViewController(sectionsVC, animated: true)
        } else {
            let sectionsVC = SectionsViewController()
            sectionsVC.modalPresentationStyle = .fullScreen
            present(sectionsVC, animated: true, completion: nil)
        }
    }
}

#Preview(){
    OnboardingViewController()
}
