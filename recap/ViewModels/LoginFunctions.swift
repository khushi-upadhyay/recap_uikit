//
//  LoginFunctions.swift
//  recap
//
//  Created by Diptayan Jash on 15/12/24.
//

import UIKit

extension PatientLoginViewController {
    
    @objc func rememberMeTapped() {
        rememberMeButton.isSelected.toggle()
    }
    
    @objc func loginTapped() {
        print("Login tapped")

        guard let loginVC = self as? PatientLoginViewController else { return }

        let email = loginVC.emailField.text ?? ""
        let password = loginVC.passwordField.text ?? ""

        if let user = demoUsers.first(where: { $0.email == email && $0.password == password }) {
            let userProfile: [String: Any] = [
                "firstName": user.firstName,
                "lastName": user.lastName,
                "email": user.email,
                "hasCompletedProfile": true
            ]

            UserDefaultsStorageProfile.shared.saveProfile(details: userProfile, image: nil) { [weak loginVC] success in
                if success {
                    let mainVC = TabbarViewController()
                    loginVC?.navigationController?.setViewControllers([mainVC], animated: true)
                } else {
                    print("Failed to save profile")
                }
            }
        } else {
            print("Invalid credentials")
            loginVC.showAlert(message: "Invalid email or password.")
        }
    }
    
    @objc func signupTapped() {
//        let signupVC = PatientSignupViewController()
//        navigationController?.pushViewController(signupVC, animated: true)
        
        let signupVC = patientInfo()
        let nav = UINavigationController(rootViewController: signupVC)
        present(nav, animated: true)
    }
    
    @objc func googleLoginTapped() {
        print("Google login tapped")
        // Implement Google login logic here
    }
    
    @objc func appleLoginTapped() {
        print("Apple login tapped")
        // Implement Apple login logic here
    }
    
    @objc func logoutTapped() {
            // Clear user session
            UserDefaults.standard.removeObject(forKey: "hasCompletedProfile")
            UserDefaultsStorageProfile.shared.clearProfile()

            // Animate the swipe down effect
            guard let window = UIApplication.shared.windows.first else { return }
            
            // Create the welcome view controller
            let welcomeVC = WelcomeViewController()
            let navigationController = UINavigationController(rootViewController: welcomeVC)
            
            // Set the initial position of the new view controller off-screen
            navigationController.view.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: window.frame.height)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
            
            // Animate the transition
            UIView.animate(withDuration: 0.5, animations: {
                // Move the current view controller off-screen
                self.view.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: window.frame.height)
                
                // Move the new view controller into view
                navigationController.view.frame = window.bounds
            }) { _ in
                // After the animation completes, set the root view controller to the new one
                window.rootViewController = navigationController
            }
        }
}
