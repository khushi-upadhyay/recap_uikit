//
//  launchScreenViewController.swift
//  recap
//
//  Created by Diptayan Jash on 14/12/24.
//

import UIKit

class launchScreenViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "recapLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        animateLogo()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        logoImageView.alpha = 0
    }
    
    private func animateLogo() {
        // Fade in animation
        UIView.animate(withDuration: 1.0, animations: { [weak self] in
            self?.logoImageView.alpha = 1
        }) { [weak self] _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.transitionToMainScreen()
            }
        }
    }
    
    private func transitionToMainScreen() {
        if UserDefaults.standard.bool(forKey: "hasCompletedProfile") {
            let tabBar = TabbarViewController()
            UIView.transition(with: view.window!,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: {
                self.view.window?.rootViewController = tabBar
            })
        } else {
//            let patientInfoVC = patientInfo()
//            patientInfoVC.delegate = UIApplication.shared.connectedScenes
//                .first?.delegate as? PatientInfoDelegate
//            let nav = UINavigationController(rootViewController: patientInfoVC)
//            
//            if let sheet = nav.sheetPresentationController {
//                sheet.detents = [.large()]
//                sheet.preferredCornerRadius = 30
//            }
//            present(nav, animated: true)
            let welcomeVC = WelcomeViewController()
            let nav = UINavigationController(rootViewController: welcomeVC)
            nav.modalPresentationStyle = .fullScreen
            
            UIView.transition(with: self.view.window!, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.view.window?.rootViewController = nav
            }, completion: nil)
        }
    }
}
#Preview{
    launchScreenViewController()
}
