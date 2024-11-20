//
//  streaksViewController.swift
//  recap
//
//  Created by Diptayan Jash on 06/11/24.
//

import UIKit

class streaksViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Streaks"
        view.backgroundColor = .systemBackground
        setupViews()
        updateStreak()
        GradientBackground()
    }
    
    private func GradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.systemOrange.withAlphaComponent(0.1).cgColor,
            UIColor.systemBackground.cgColor,
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0.6)
        gradientLayer.frame = view.bounds

        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    private let progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .bar)
        progress.progressTintColor = .systemGreen
        progress.trackTintColor = .systemGray5
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    private let streakLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 48)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupViews() {
        view.addSubview(progressView)
        view.addSubview(streakLabel)
        
        NSLayoutConstraint.activate([
            streakLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            streakLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.topAnchor.constraint(equalTo: streakLabel.bottomAnchor, constant: 20),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            progressView.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    private func updateStreak() {
        streakLabel.text = "7 Days"
        progressView.setProgress(0.7, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
#Preview() {
    streaksViewController()
}
