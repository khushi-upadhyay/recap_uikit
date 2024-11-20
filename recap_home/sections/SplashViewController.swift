//
//  SplashViewController.swift
//  recap_home
//
//  Created by user@47 on 13/11/24.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()
        setupUI()
    }

    private func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 0.69, green: 0.88, blue: 0.88, alpha: 1.0).cgColor, UIColor(red: 0.94, green: 0.74, blue: 0.80, alpha: 1.0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func setupUI() {
        
        let logoImageView = UIImageView(image: UIImage(named: "logo"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)

        let recapLabel = UILabel()
        recapLabel.text = "Recap"
        recapLabel.font = UIFont(name: "ArialRoundedMTBold", size: 30)
        recapLabel.textColor = .darkGray
        recapLabel.textAlignment = .center
        recapLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recapLabel)

        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),

            recapLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 10),
            recapLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.navigateToOnboarding()
        }
    }

    private func navigateToOnboarding() {
        let onboardingVC = OnboardingViewController()
        onboardingVC.modalTransitionStyle = .coverVertical
        onboardingVC.modalPresentationStyle = .overFullScreen
        self.present(onboardingVC, animated: true, completion: nil)
    }
}
