//
//  PatientLoginViewController.swift
//  recap
//
//  Created by Diptayan Jash on 15/12/24.
//

import UIKit

class PatientLoginViewController: UIViewController {
    
    // MARK: - UI Components
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "recapLogo")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login 👋"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
     let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email address"
        field.keyboardType = .emailAddress
        field.backgroundColor = .systemGray6
        field.layer.cornerRadius = 12
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        field.autocapitalizationType = .none
        return field
    }()
    
     let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        field.backgroundColor = .systemGray6
        field.layer.cornerRadius = 12
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftViewMode = .always
        
        // Add show/hide password button
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = .systemGray
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        field.rightView = button
        field.rightViewMode = .always
        
        return field
    }()
    
    let rememberMeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Remember me", for: .normal)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
        button.tintColor = .systemBlue
        return button
    }()
    
    fileprivate let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot password?", for: .normal)
        button.tintColor = .black
        return button
    }()
    
    fileprivate let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        return button
    }()
    
    private let dividerLabel: UILabel = {
        let label = UILabel()
        label.text = "Or Login with"
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let socialButtonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()
    
    fileprivate let googleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "google"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        return button
    }()
    
    fileprivate let appleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "apple"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = .systemBackground
        button.tintColor = .label
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray4.cgColor
        return button
    }()
    
    private let signupPromptLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Patient Login"
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Add subviews
        [logoImageView, titleLabel, emailField, passwordField, rememberMeButton, 
         forgotPasswordButton, loginButton, dividerLabel, socialButtonsStack, 
         signupPromptLabel, signupButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // Setup social buttons stack
        socialButtonsStack.addArrangedSubview(googleButton)
        socialButtonsStack.addArrangedSubview(appleButton)
        
        // Set specific sizes for social buttons
        NSLayoutConstraint.activate([
            googleButton.widthAnchor.constraint(equalToConstant: 105),
            googleButton.heightAnchor.constraint(equalToConstant: 50),
            appleButton.widthAnchor.constraint(equalToConstant: 105),
            appleButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Setup constraints
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            emailField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 16),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordField.heightAnchor.constraint(equalToConstant: 50),
            
            rememberMeButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16),
            rememberMeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            forgotPasswordButton.centerYAnchor.constraint(equalTo: rememberMeButton.centerYAnchor),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            loginButton.topAnchor.constraint(equalTo: rememberMeButton.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            dividerLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30),
            dividerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            socialButtonsStack.topAnchor.constraint(equalTo: dividerLabel.bottomAnchor, constant: 20),
            socialButtonsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signupPromptLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            signupPromptLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -30),
            
            signupButton.centerYAnchor.constraint(equalTo: signupPromptLabel.centerYAnchor),
            signupButton.leadingAnchor.constraint(equalTo: signupPromptLabel.trailingAnchor, constant: 4)
        ])
        
        // Add targets
        rememberMeButton.addTarget(self, action: #selector(rememberMeTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleLoginTapped), for: .touchUpInside)
        appleButton.addTarget(self, action: #selector(appleLoginTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        passwordField.isSecureTextEntry.toggle()
        let imageName = passwordField.isSecureTextEntry ? "eye.slash" : "eye"
        sender.setImage(UIImage(systemName: imageName), for: .normal)
    }

}
