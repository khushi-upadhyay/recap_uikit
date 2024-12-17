    @objc private func rememberMeTapped() {
        rememberMeButton.isSelected.toggle()
    }
    
    @objc private func loginTapped() {
        print("Login tapped")
    }
    
    @objc private func signupTapped() {
        let signupVC = PatientSignupViewController()
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
    @objc private func googleLoginTapped() {
        print("Google login tapped")
    }
    
    @objc private func appleLoginTapped() {
        print("Apple login tapped")
    }