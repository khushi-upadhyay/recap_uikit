//
//  FamilyMainScreenViewController.swift
//  recap_home
//
//  Created by user@47 on 19/11/24.
//

import UIKit

class FamilyMainScreenViewController: UIViewController {
    
    private let immediateGraphView = UIView()
    private let recentGraphView = UIView()
    private let remoteGraphView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 0.69, green: 0.88, blue: 0.88, alpha: 1.0).cgColor, UIColor(red: 0.94, green: 0.74, blue: 0.80, alpha: 1.0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        // Home Label
        let homeLabel = UILabel()
        homeLabel.text = "Home"
        homeLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        homeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(homeLabel)
        
        let dailyQuestionsView = createCardView()
        view.addSubview(dailyQuestionsView)
        
        let dailyImageView = UIImageView(image: UIImage(systemName: "questionmark.circle"))
        dailyImageView.tintColor = .systemPurple
        dailyImageView.contentMode = .scaleAspectFit
        dailyImageView.translatesAutoresizingMaskIntoConstraints = false
        dailyQuestionsView.addSubview(dailyImageView)
        
        let dailyTitleLabel = UILabel()
        dailyTitleLabel.text = "Daily Questions"
        dailyTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        dailyTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        dailyQuestionsView.addSubview(dailyTitleLabel)
        
        let dailyDescriptionLabel = UILabel()
        dailyDescriptionLabel.text = "A little effort each day keeps the memory strong – do it for the love you share with your family."
        dailyDescriptionLabel.font = UIFont.systemFont(ofSize: 16)
        dailyDescriptionLabel.textColor = .gray
        dailyDescriptionLabel.numberOfLines = 0
        dailyDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        dailyQuestionsView.addSubview(dailyDescriptionLabel)
        
        let streaksView = createCardView()
        view.addSubview(streaksView)
        
        let streaksLabel = UILabel()
        streaksLabel.text = "Streaks"
        streaksLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        streaksLabel.translatesAutoresizingMaskIntoConstraints = false
        streaksView.addSubview(streaksLabel)
        
        let statsStackView = UIStackView()
        statsStackView.axis = .horizontal
        statsStackView.distribution = .fillEqually
        statsStackView.spacing = 12
        statsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let maxStreakView = createStatView(title: "Max Streak", value: "9")
        let currentStreakView = createStatView(title: "Current Streak", value: "5")
        let activeDaysView = createStatView(title: "Active Days", value: "18")
        
        statsStackView.addArrangedSubview(maxStreakView)
        statsStackView.addArrangedSubview(currentStreakView)
        statsStackView.addArrangedSubview(activeDaysView)
        
        streaksView.addSubview(statsStackView)
        
        let graphsView = createCardView()
        view.addSubview(graphsView)
        
        let graphsLabel = UILabel()
        graphsLabel.text = "Trends"
        graphsLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        graphsLabel.translatesAutoresizingMaskIntoConstraints = false
        graphsView.addSubview(graphsLabel)
        
        let segmentedControl = UISegmentedControl(items: ["Immediate", "Recent", "Remote"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        graphsView.addSubview(segmentedControl)
        
        setupGraph(immediateGraphView, type: "circle", icon: "chart.pie.fill")
        setupGraph(recentGraphView, type: "bar", icon: "chart.bar.fill")
        setupGraph(remoteGraphView, type: "line", icon: "waveform.path.ecg")
        
        graphsView.addSubview(immediateGraphView)
        graphsView.addSubview(recentGraphView)
        graphsView.addSubview(remoteGraphView)
        
        recentGraphView.isHidden = true
        remoteGraphView.isHidden = true
        
        NSLayoutConstraint.activate([
            homeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            homeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            dailyQuestionsView.topAnchor.constraint(equalTo: homeLabel.bottomAnchor, constant: 16),
            dailyQuestionsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dailyQuestionsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dailyQuestionsView.heightAnchor.constraint(equalToConstant: 160),
            
            dailyImageView.centerYAnchor.constraint(equalTo: dailyQuestionsView.centerYAnchor),
            dailyImageView.leadingAnchor.constraint(equalTo: dailyQuestionsView.leadingAnchor, constant: 16),
            dailyImageView.widthAnchor.constraint(equalToConstant: 40),
            dailyImageView.heightAnchor.constraint(equalToConstant: 40),
            
            dailyTitleLabel.topAnchor.constraint(equalTo: dailyQuestionsView.topAnchor, constant: 16),
            dailyTitleLabel.leadingAnchor.constraint(equalTo: dailyImageView.trailingAnchor, constant: 16),
            
            dailyDescriptionLabel.topAnchor.constraint(equalTo: dailyTitleLabel.bottomAnchor, constant: 4),
            dailyDescriptionLabel.leadingAnchor.constraint(equalTo: dailyImageView.trailingAnchor, constant: 16),
            dailyDescriptionLabel.trailingAnchor.constraint(equalTo: dailyQuestionsView.trailingAnchor, constant: -16),
            
            streaksView.topAnchor.constraint(equalTo: dailyQuestionsView.bottomAnchor, constant: 16),
            streaksView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            streaksView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            streaksView.heightAnchor.constraint(equalToConstant: 150),
            
            streaksLabel.topAnchor.constraint(equalTo: streaksView.topAnchor, constant: 16),
            streaksLabel.leadingAnchor.constraint(equalTo: streaksView.leadingAnchor, constant: 16),
            
            statsStackView.topAnchor.constraint(equalTo: streaksLabel.bottomAnchor, constant: 16),
            statsStackView.leadingAnchor.constraint(equalTo: streaksView.leadingAnchor, constant: 16),
            statsStackView.trailingAnchor.constraint(equalTo: streaksView.trailingAnchor, constant: -16),
            statsStackView.heightAnchor.constraint(equalToConstant: 50),
            
            graphsView.topAnchor.constraint(equalTo: streaksView.bottomAnchor, constant: 16),
            graphsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            graphsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            graphsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            graphsLabel.topAnchor.constraint(equalTo: graphsView.topAnchor, constant: 16),
            graphsLabel.leadingAnchor.constraint(equalTo: graphsView.leadingAnchor, constant: 16),
            
            segmentedControl.topAnchor.constraint(equalTo: graphsLabel.bottomAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: graphsView.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: graphsView.trailingAnchor, constant: -16),
            
            immediateGraphView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            immediateGraphView.leadingAnchor.constraint(equalTo: graphsView.leadingAnchor, constant: 16),
            immediateGraphView.trailingAnchor.constraint(equalTo: graphsView.trailingAnchor, constant: -16),
            immediateGraphView.heightAnchor.constraint(equalToConstant: 150),
            
            recentGraphView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            recentGraphView.leadingAnchor.constraint(equalTo: graphsView.leadingAnchor, constant: 16),
            recentGraphView.trailingAnchor.constraint(equalTo: graphsView.trailingAnchor, constant: -16),
            recentGraphView.heightAnchor.constraint(equalToConstant: 150),
            
            remoteGraphView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            remoteGraphView.leadingAnchor.constraint(equalTo: graphsView.leadingAnchor, constant: 16),
            remoteGraphView.trailingAnchor.constraint(equalTo: graphsView.trailingAnchor, constant: -16),
            remoteGraphView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func createCardView() -> UIView {
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 12
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 4
        cardView.translatesAutoresizingMaskIntoConstraints = false
        return cardView
    }
    
    private func createStatView(title: String, value: String) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        valueLabel.textAlignment = .center
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = .gray
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(valueLabel)
        containerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        return containerView
    }
    
    private func setupGraph(_ graphView: UIView, type: String, icon: String) {
        graphView.backgroundColor = .systemGray6
        graphView.layer.cornerRadius = 8
        graphView.translatesAutoresizingMaskIntoConstraints = false
        
        let iconView = UIImageView(image: UIImage(systemName: icon))
        iconView.tintColor = .systemBlue
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        graphView.addSubview(iconView)
        
        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: graphView.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: graphView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 100),
            iconView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc private func segmentedControlChanged(_ sender: UISegmentedControl) {
        immediateGraphView.isHidden = sender.selectedSegmentIndex != 0
        recentGraphView.isHidden = sender.selectedSegmentIndex != 1
        remoteGraphView.isHidden = sender.selectedSegmentIndex != 2
    }
}

#Preview() {
    FamilyMainScreenViewController()
}
