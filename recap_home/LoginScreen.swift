//
//  LoginScreen.swift
//  recap_home
//
//  Created by user@47 on 18/11/24.
//
import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        // Title Label
        let titleLabel = UILabel()
        titleLabel.text = "Welcome Back"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 34)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // Continue with Google Button
        let googleButton = createButton(title: "Continue with Google", backgroundColor: .systemGray6, image: UIImage(named: "google_icon"))
        googleButton.addTarget(self, action: #selector(continueWithGoogleTapped), for: .touchUpInside)
        view.addSubview(googleButton)
        
        // Continue with Apple Button
        let appleButton = createButton(title: "Continue with Apple", backgroundColor: .black, image: UIImage(systemName: "applelogo"))
        appleButton.setTitleColor(.white, for: .normal)
        appleButton.addTarget(self, action: #selector(continueWithAppleTapped), for: .touchUpInside)
        view.addSubview(appleButton)
        
        // Continue with Email Button
        let emailButton = createButton(title: "Continue with Email", backgroundColor: .systemBlue, image: UIImage(systemName: "envelope"))
        emailButton.setTitleColor(.white, for: .normal)
        emailButton.addTarget(self, action: #selector(continueWithEmailTapped), for: .touchUpInside)
        view.addSubview(emailButton)
        
        // Terms and Conditions Label
        let termsLabel = UILabel()
        let termsText = "Already have an account? Login"
        let attributedString = NSMutableAttributedString(string: termsText)
        attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: (termsText as NSString).range(of: "Login"))
        termsLabel.attributedText = attributedString
        termsLabel.font = UIFont.systemFont(ofSize: 14)
        termsLabel.textAlignment = .center
        termsLabel.isUserInteractionEnabled = true
        termsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(termsLabel)
        
        // Add tap gesture to Login
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(loginTapped))
        termsLabel.addGestureRecognizer(tapGesture)
        
        // Constraints
        NSLayoutConstraint.activate([
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Google Button
            googleButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            googleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            googleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            googleButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Apple Button
            appleButton.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: 20),
            appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            appleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            appleButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Email Button
            emailButton.topAnchor.constraint(equalTo: appleButton.bottomAnchor, constant: 20),
            emailButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Terms Label
            termsLabel.topAnchor.constraint(equalTo: emailButton.bottomAnchor, constant: 20),
            termsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // Helper method to create buttons
    private func createButton(title: String, backgroundColor: UIColor, image: UIImage?) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if let icon = image {
            button.setImage(icon, for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        }
        return button
    }
    
    // Button Actions
    @objc func continueWithGoogleTapped() {
        print("Continue with Google tapped")
        // Handle Google login
    }
    
    @objc func continueWithAppleTapped() {
        print("Continue with Apple tapped")
        // Handle Apple login
    }
    
    @objc func continueWithEmailTapped() {
        print("Continue with Email tapped")
        // Handle Email login
    }
    
    @objc func loginTapped() {
        print("Login tapped")
        // Navigate to Login screen or handle login action
    }
}

#Preview(){
    LoginViewController()
}
