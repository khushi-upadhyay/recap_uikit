//
//  sections.swift
//  recap_home
//
//  Created by user@47 on 13/11/24.
//
import UIKit

class SectionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()
        setupUI()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 0.69, green: 0.88, blue: 0.88, alpha: 1.0).cgColor, UIColor(red: 0.94, green: 0.74, blue: 0.80, alpha: 1.0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    func setupUI() {
        let recapLabel = UILabel()
        recapLabel.text = "Recap"
        recapLabel.font = UIFont(name: "ArialRoundedMTBold", size: 30)
        recapLabel.textAlignment = .center
        recapLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recapLabel)

        let logoImageView = UIImageView(image: UIImage(named: "logo"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)

        let patientButton = UIButton(type: .system)
        patientButton.setTitle("Patient", for: .normal)
        patientButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        patientButton.backgroundColor = UIColor(red: 226/255, green: 240/255, blue: 253/255, alpha: 1.0)
        patientButton.setTitleColor(.blue, for: .normal)
        patientButton.layer.cornerRadius = 20
        patientButton.translatesAutoresizingMaskIntoConstraints = false
        patientButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(patientButton)

        let familyButton = UIButton(type: .system)
        familyButton.setTitle("Family", for: .normal)
        familyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        familyButton.backgroundColor = UIColor(red: 226/255, green: 240/255, blue: 253/255, alpha: 1.0)
        familyButton.setTitleColor(.blue, for: .normal)
        familyButton.layer.cornerRadius = 20
        familyButton.translatesAutoresizingMaskIntoConstraints = false
        familyButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside) // Corrected selector
        view.addSubview(familyButton)

        NSLayoutConstraint.activate([
            recapLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            recapLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            logoImageView.topAnchor.constraint(equalTo: recapLabel.bottomAnchor, constant: 20),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 180), // Increased width
            logoImageView.heightAnchor.constraint(equalToConstant: 180), // Increased height

            patientButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30), // Increased spacing
            patientButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            patientButton.widthAnchor.constraint(equalToConstant: 220),
            patientButton.heightAnchor.constraint(equalToConstant: 50),

            familyButton.topAnchor.constraint(equalTo: patientButton.bottomAnchor, constant: 20),
            familyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            familyButton.widthAnchor.constraint(equalToConstant: 220),
            familyButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func didTapButton() {
        let createAccountVC = CreateAccountViewController()
        createAccountVC.modalPresentationStyle = .fullScreen
        self.present(createAccountVC, animated: true, completion: nil)
        navigationController?.pushViewController(createAccountVC, animated: true)
    }
}


#Preview() {
    SectionsViewController()
}
