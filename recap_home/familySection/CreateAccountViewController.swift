//
//  CreateAccountView.swift
//  recap_home
//
//  Created by user@47 on 18/11/24.
//
//
//import UIKit
//
//class CreateAccountViewController: UIViewController {
//    
//    private let contentView = UIView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupGradientBackground()
//        setupContentView()
//
//        let titleLabel = UILabel()
//        titleLabel.text = "Create Account"
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 34)
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(titleLabel)
//
//        let googleButton = createButton(title: "Continue with Google", backgroundColor: .white, image: UIImage(named: "google_icon"))
//        googleButton.addTarget(self, action: #selector(continueWithGoogleTapped), for: .touchUpInside)
//        contentView.addSubview(googleButton)
//
//        let appleButton = createButton(title: "Continue with Apple", backgroundColor: .white, image: UIImage(systemName: "applelogo"))
//        appleButton.setTitleColor(.black, for: .normal)
//        appleButton.addTarget(self, action: #selector(continueWithAppleTapped), for: .touchUpInside)
//        contentView.addSubview(appleButton)
//
//        let emailButton = createButton(title: "Continue with Email", backgroundColor: .white, image: UIImage(systemName: "envelope"))
//        emailButton.setTitleColor(.black, for: .normal)
//        emailButton.addTarget(self, action: #selector(continueWithEmailTapped), for: .touchUpInside)
//        contentView.addSubview(emailButton)
//
//        let loginLabel = UILabel()
//        let attributedString = NSMutableAttributedString(string: "Already have an account? Login")
//        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: attributedString.length))
//        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
//        loginLabel.attributedText = attributedString
//        loginLabel.textAlignment = .center
//        loginLabel.isUserInteractionEnabled = true
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(loginTapped))
//        loginLabel.addGestureRecognizer(tapGesture)
//        loginLabel.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(loginLabel)
//
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 80),
//            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//
//            googleButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
//            googleButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            googleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            googleButton.heightAnchor.constraint(equalToConstant: 50),
//
//            appleButton.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: 20),
//            appleButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            appleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            appleButton.heightAnchor.constraint(equalToConstant: 50),
//
//            emailButton.topAnchor.constraint(equalTo: appleButton.bottomAnchor, constant: 20),
//            emailButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            emailButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            emailButton.heightAnchor.constraint(equalToConstant: 50),
//
//            loginLabel.topAnchor.constraint(equalTo: emailButton.bottomAnchor, constant: 30),
//            loginLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//
//            contentView.topAnchor.constraint(equalTo: view.topAnchor),
//            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//
//    private func setupGradientBackground() {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [
//            UIColor(red: 241/255, green: 247/255, blue: 249/255, alpha: 1.0).cgColor,
//            UIColor(red: 226/255, green: 240/255, blue: 253/255, alpha: 1.0).cgColor
//        ]
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
//        gradientLayer.frame = view.bounds
//        view.layer.insertSublayer(gradientLayer, at: 0)
//    }
//
//    private func createButton(title: String, backgroundColor: UIColor, image: UIImage?) -> UIButton {
//        let button = UIButton(type: .system)
//        button.setTitle(title, for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        button.backgroundColor = backgroundColor
//        button.layer.cornerRadius = 25
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.black.cgColor
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        
//        if let icon = image {
//            button.setImage(icon, for: .normal)
//            button.tintColor = .black
//            button.imageView?.contentMode = .scaleAspectFit
//            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
//        }
//        return button
//    }
//
//    @objc private func continueWithGoogleTapped() {
//        print("Continue with Google tapped")
//        let addPatientDetailsVC = AddPatientDetailsViewController()
//        self.present(addPatientDetailsVC, animated: true, completion: nil)
//        navigationController?.pushViewController(addPatientDetailsVC, animated: true)
//    }
//
//    @objc private func continueWithAppleTapped() {
//        print("Continue with Apple tapped")
//        let addPatientDetailsVC = AddPatientDetailsViewController()
//        self.present(addPatientDetailsVC, animated: true, completion: nil)
//        navigationController?.pushViewController(addPatientDetailsVC, animated: true)
//    }
//
//    @objc private func continueWithEmailTapped() {
//        print("Continue with Email tapped")
//        let emailSignUpVC = EmailSignUpViewController()
//        self.present(emailSignUpVC, animated: true, completion: nil)
//        navigationController?.pushViewController(emailSignUpVC, animated: true)
//    }
//
//    @objc private func loginTapped() {
//        print("Login tapped")
//        let loginVC = LoginViewController()
//        navigationController?.pushViewController(loginVC, animated: true)
//    }
//
//    private func setupContentView() {
//        contentView.backgroundColor = .white
//        contentView.layer.cornerRadius = 20
//        contentView.layer.masksToBounds = true
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(contentView)
//    }
//}
//
//#Preview() {
//    CreateAccountViewController()
//}


import UIKit

class CreateAccountViewController: UIViewController {
    
    private let contentView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()
        setupContentView()

        let titleLabel = UILabel()
        titleLabel.text = "Create Account"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 34)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        let googleButton = createButton(title: "Continue with Google", backgroundColor: .white, image: UIImage(named: "google_icon"))
        googleButton.addTarget(self, action: #selector(continueWithGoogleTapped), for: .touchUpInside)
        contentView.addSubview(googleButton)

        let appleButton = createButton(title: "Continue with Apple", backgroundColor: .white, image: UIImage(systemName: "applelogo"))
        appleButton.setTitleColor(.black, for: .normal)
        appleButton.addTarget(self, action: #selector(continueWithAppleTapped), for: .touchUpInside)
        contentView.addSubview(appleButton)

        let emailButton = createButton(title: "Continue with Email", backgroundColor: .white, image: UIImage(systemName: "envelope"))
        emailButton.setTitleColor(.black, for: .normal)
        emailButton.addTarget(self, action: #selector(continueWithEmailTapped), for: .touchUpInside)
        contentView.addSubview(emailButton)

        let loginLabel = UILabel()
        let attributedString = NSMutableAttributedString(string: "Already have an account? Login")
        
        // Style the "Already have an account?" part
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: attributedString.length - 5))
        
        // Style the "Login" part to be blue and underlined
        attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: NSRange(location: attributedString.length - 5, length: 5))
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: attributedString.length - 5, length: 5))
        
        loginLabel.attributedText = attributedString
        loginLabel.textAlignment = .center
        loginLabel.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(loginTapped))
        loginLabel.addGestureRecognizer(tapGesture)
        
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(loginLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 80),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            googleButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            googleButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            googleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            googleButton.heightAnchor.constraint(equalToConstant: 50),

            appleButton.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: 20),
            appleButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            appleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            appleButton.heightAnchor.constraint(equalToConstant: 50),

            emailButton.topAnchor.constraint(equalTo: appleButton.bottomAnchor, constant: 20),
            emailButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            emailButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            emailButton.heightAnchor.constraint(equalToConstant: 50),

            loginLabel.topAnchor.constraint(equalTo: emailButton.bottomAnchor, constant: 30),
            loginLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

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

    private func createButton(title: String, backgroundColor: UIColor, image: UIImage?) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if let icon = image {
            button.setImage(icon, for: .normal)
            button.tintColor = .black
            button.imageView?.contentMode = .scaleAspectFit
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        }
        return button
    }

    @objc private func continueWithGoogleTapped() {
        print("Continue with Google tapped")
        let addPatientDetailsVC = AddPatientDetailsViewController()
        self.present(addPatientDetailsVC, animated: true, completion: nil)
        navigationController?.pushViewController(addPatientDetailsVC, animated: true)
    }

    @objc private func continueWithAppleTapped() {
        print("Continue with Apple tapped")
        let addPatientDetailsVC = AddPatientDetailsViewController()
        self.present(addPatientDetailsVC, animated: true, completion: nil)
        navigationController?.pushViewController(addPatientDetailsVC, animated: true)
    }

    @objc private func continueWithEmailTapped() {
        print("Continue with Email tapped")
        let emailSignUpVC = EmailSignUpViewController()
        self.present(emailSignUpVC, animated: true, completion: nil)
        navigationController?.pushViewController(emailSignUpVC, animated: true)
    }

    @objc private func loginTapped() {
        print("Login tapped")
        let familyMainScreenVC = FamilyMainScreenViewController()
        navigationController?.pushViewController(familyMainScreenVC, animated: true)
    }

    private func setupContentView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
    }
}

#Preview() {
    CreateAccountViewController()
}
