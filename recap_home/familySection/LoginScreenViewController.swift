//
//  LoginScreenViewController.swift
//  recap_home
//
//  Created by user@47 on 18/11/24.
//


import UIKit

class LoginScreenViewController: UIViewController {
    
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton()
    private let forgotPasswordLabel = UILabel()
    private let signupLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Title label
        let titleLabel = UILabel()
        titleLabel.text = "Log In"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 34)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // Email TextField
        setupTextField(emailTextField, placeholder: "Email Address")
        
        // Password TextField
        setupSecureTextField(passwordTextField, placeholder: "Password")
        
        // Login Button
        setupLoginButton()
        
        // Forgot Password Label
        forgotPasswordLabel.text = "Forgot Password?"
        forgotPasswordLabel.textColor = .blue
        forgotPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordLabel.isUserInteractionEnabled = true
        forgotPasswordLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapForgotPassword)))
        view.addSubview(forgotPasswordLabel)
        
        // Sign-up Label
        signupLabel.text = "Don’t have an account? Sign up"
        signupLabel.textColor = .blue
        signupLabel.translatesAutoresizingMaskIntoConstraints = false
        signupLabel.isUserInteractionEnabled = true
        signupLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapSignup)))
        view.addSubview(signupLabel)
        
        // Set up layout constraints
        NSLayoutConstraint.activate([
            // Title label constraints
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Email TextField constraints
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            
            // Password TextField constraints
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            // Login Button constraints
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Forgot Password Label constraints
            forgotPasswordLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            forgotPasswordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Sign Up Label constraints
            signupLabel.topAnchor.constraint(equalTo: forgotPasswordLabel.bottomAnchor, constant: 10),
            signupLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // Setup text field for email
    private func setupTextField(_ textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
    }
    
    // Setup secure text field for password
    private func setupSecureTextField(_ textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
    }
    
    // Login Button setup
    private func setupLoginButton() {
        loginButton.setTitle("Log In", for: .normal)
        loginButton.backgroundColor = .black
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
    }
    
    // Handle login button tap
    @objc private func loginTapped() {
        // Handle login action here
        print("Log In button tapped")
    }
    
    // Handle Forgot Password tap
    @objc private func didTapForgotPassword() {
        // Handle forgot password action
        print("Forgot Password tapped")
    }
    
    // Handle Sign Up tap
    @objc private func didTapSignup() {
        // Navigate to Sign Up screen
        print("Sign Up tapped")
        // For example, push a SignUp screen if you have one
    }
}

#Preview() {
    LoginScreenViewController()
}
