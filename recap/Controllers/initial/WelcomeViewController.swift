//
//  WelcomeViewController.swift
//  recap
//
//  Created by Diptayan Jash on 05/11/24.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    // MARK: - UI Components
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "recapLogo")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Recap"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let patientButton: UIButton = {
        let button = UIButton()
        button.setTitle("Patient", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .systemBlue.withAlphaComponent(0.1)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        return button
    }()
    
    private let familyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Family", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .systemBlue.withAlphaComponent(0.1)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        return button
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        // Add shadow
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.1
        return view
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
//            UIColor.systemBlue.cgColor,
//            UIColor.systemPurple.cgColor
            UIColor(red: 0.69, green: 0.88, blue: 0.88, alpha: 1.0).cgColor,
            UIColor(red: 0.94, green: 0.74, blue: 0.80, alpha: 1.0).cgColor

            
        ]
//        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        return gradient
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
           navigationController?.setNavigationBarHidden(true, animated: false)
       }
       
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           navigationController?.setNavigationBarHidden(true, animated: animated)
       }
       
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           navigationController?.setNavigationBarHidden(false, animated: animated)
       }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Add gradient background
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.69, green: 0.88, blue: 0.88, alpha: 1.0).cgColor,
            UIColor(red: 0.94, green: 0.74, blue: 0.80, alpha: 1.0).cgColor

        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        // Add subviews
        view.addSubview(containerView)
        [logoImageView, titleLabel, patientButton, familyButton].forEach {
            containerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup constraints
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 350),
            containerView.heightAnchor.constraint(equalToConstant: 514),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            logoImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.heightAnchor.constraint(equalToConstant: 180),
            
            patientButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            patientButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            patientButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            patientButton.heightAnchor.constraint(equalToConstant: 50),
            
            familyButton.topAnchor.constraint(equalTo: patientButton.bottomAnchor, constant: 16),
            familyButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            familyButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            familyButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Add button targets
        patientButton.addTarget(self, action: #selector(patientButtonTapped), for: .touchUpInside)
        familyButton.addTarget(self, action: #selector(familyButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func patientButtonTapped() {
           let patientLoginVC = PatientLoginViewController()
           navigationController?.pushViewController(patientLoginVC, animated: true)
       }
    
    @objc private func familyButtonTapped() {
        print("Family button tapped")
        // let familyLoginVC = FamilyLoginViewController()
        // navigationController?.pushViewController(familyLoginVC, animated: true)
    }
}
