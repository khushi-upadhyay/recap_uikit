//
//  LoginViewController.swift
//  recap_home
//
//  Created by user@47 on 19/11/24.
//

import UIKit

class LoginOptionsViewController: UIViewController {
    
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let confirmPasswordTextField = UITextField()
    private let createAccountButton = UIButton()
    private let termsLabel = UILabel()
    
    private let contentView = UIView() // Content view with white background

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up gradient background
        setupGradientBackground()
        
        // Set up the content view with white background
        setupContentView()

        // Title label
        let titleLabel = UILabel()
        titleLabel.text = "Login"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 34)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        // Google Button
        let googleButton = createButton(title: "Continue with Google", backgroundColor: .white, image: UIImage(named: "google_icon"))
        googleButton.addTarget(self, action: #selector(continueWithGoogleTapped), for: .touchUpInside)
        contentView.addSubview(googleButton)

        // Apple Button
        let appleButton = createButton(title: "Continue with Apple", backgroundColor: .white, image: UIImage(systemName: "applelogo"))
        appleButton.setTitleColor(.black, for: .normal) // Ensuring text is black
        appleButton.addTarget(self, action: #selector(continueWithAppleTapped), for: .touchUpInside)
        contentView.addSubview(appleButton)

        // Email Button
        let emailButton = createButton(title: "Continue with Email", backgroundColor: .white, image: UIImage(systemName: "envelope"))
        emailButton.setTitleColor(.black, for: .normal) // Ensuring text is black
        emailButton.addTarget(self, action: #selector(continueWithEmailTapped), for: .touchUpInside)
        contentView.addSubview(emailButton)

        // "Already have an account? Login" Label with black and underlined text
        let loginLabel = UILabel()
        let attributedString = NSMutableAttributedString(string: "Don’t have an account? Signup")
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        loginLabel.attributedText = attributedString
        loginLabel.textAlignment = .center
        loginLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(loginTapped))
        loginLabel.addGestureRecognizer(tapGesture)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(loginLabel)

        // Set up layout constraints
        NSLayoutConstraint.activate([
            // Title label constraints
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 80),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            // Google Button constraints
            googleButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            googleButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            googleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            googleButton.heightAnchor.constraint(equalToConstant: 50),

            // Apple Button constraints
            appleButton.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: 20),
            appleButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            appleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            appleButton.heightAnchor.constraint(equalToConstant: 50),

            // Email Button constraints
            emailButton.topAnchor.constraint(equalTo: appleButton.bottomAnchor, constant: 20),
            emailButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            emailButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            emailButton.heightAnchor.constraint(equalToConstant: 50),

            // Login Label constraints
            loginLabel.topAnchor.constraint(equalTo: emailButton.bottomAnchor, constant: 30),
            loginLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            // Content View Constraints to fill the screen
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 241/255, green: 247/255, blue: 249/255, alpha: 1.0).cgColor,
            UIColor(red: 226/255, green: 240/255, blue: 253/255, alpha: 1.0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    // Helper method to create buttons
    private func createButton(title: String, backgroundColor: UIColor, image: UIImage?) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal) // Ensuring text color is black
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 25 // Complete circle (half the height of the button)
        button.layer.borderWidth = 1 // Adding a border
        button.layer.borderColor = UIColor.black.cgColor // Border color
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if let icon = image {
            button.setImage(icon, for: .normal)
            button.tintColor = .black // Set the icon color to black
            button.imageView?.contentMode = .scaleAspectFit
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        }
        return button
    }

    // Button Actions
    @objc private func continueWithGoogleTapped() {
        print("Continue with Google tapped")
        // Navigate to AddPatientDetailsViewController for Google login
        let addPatientDetailsVC = AddPatientDetailsViewController() // Assuming you have this view controller
        navigationController?.pushViewController(addPatientDetailsVC, animated: true)
    }

    @objc private func continueWithAppleTapped() {
        print("Continue with Apple tapped")
        // Navigate to AddPatientDetailsViewController for Apple login
        let addPatientDetailsVC = AddPatientDetailsViewController() // Assuming you have this view controller
        navigationController?.pushViewController(addPatientDetailsVC, animated: true)
    }

    @objc private func continueWithEmailTapped() {
        print("Continue with Email tapped")
        // Navigate to EmailSignUpViewController
        let emailSignUpVC = EmailSignUpViewController() // Assuming you have this view controller
        navigationController?.pushViewController(emailSignUpVC, animated: true)
    }

    @objc private func loginTapped() {
        print("Login tapped")
        // Navigate to LoginViewController
        let loginVC = LoginViewController() // Assuming you have a login screen
        navigationController?.pushViewController(loginVC, animated: true)
    }

    // Helper method to set up the content view with white background
    private func setupContentView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20 // Optional: To round the corners of the content view
        contentView.layer.masksToBounds = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
    }
}

#Preview() {
    LoginOptionsViewController()
}
