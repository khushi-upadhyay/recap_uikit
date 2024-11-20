//
//  ViewController.swift
//  Recap
//
//  Created by admin70 on 04/11/24.

import UIKit

class FamilyMainScreenViewController: UIViewController {
    
    private let immediateGraphView = UIView()
    private let recentGraphView = UIView()
    private let remoteGraphView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTapGestures()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        
       // MARK: - Gradient Background
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.69, green: 0.88, blue: 0.88, alpha: 1.0).cgColor,
            UIColor(red: 0.94, green: 0.74, blue: 0.80, alpha: 1.0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        // MARK: -  Daily Questions Card
        let dailyQuestionsView = createCardView()
        view.addSubview(dailyQuestionsView)
        dailyQuestionsView.tag = 1
    

        
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
        
        dailyQuestionsView.tag = 1
        
        // MARK: -  Streak Stats Section
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
        
        // MARK: - Graph
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
        
        immediateGraphView.tag = 2
        recentGraphView.tag = 3
        remoteGraphView.tag = 4
        
        recentGraphView.isHidden = true
        remoteGraphView.isHidden = true
        
        // MARK: -  Layout Constraints
        NSLayoutConstraint.activate([
            dailyQuestionsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
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
        let statView = UIView()
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .gray
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        valueLabel.textColor = .black
        
        let stackView = UIStackView(arrangedSubviews: [valueLabel, titleLabel ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        statView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: statView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: statView.centerYAnchor)
        ])
        
        return statView
    }
    
    private func setupGraph(_ view: UIView, type: String, icon: String) {
        view.backgroundColor = UIColor.systemGray6
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        let iconImageView = UIImageView(image: UIImage(systemName: icon))
        iconImageView.tintColor = .systemBlue
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 80),
            iconImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setupTapGestures() {
        let dailyQuestionsTap = UITapGestureRecognizer(target: self, action: #selector(navigateToDetailView(_:)))
        if let dailyQuestionsView = view.viewWithTag(1) {
            dailyQuestionsView.addGestureRecognizer(dailyQuestionsTap)
        }
        
        let immediateTap = UITapGestureRecognizer(target: self, action: #selector(navigateToDetailView(_:)))
        immediateGraphView.addGestureRecognizer(immediateTap)
        
        let recentTap = UITapGestureRecognizer(target: self, action: #selector(navigateToDetailView(_:)))
        recentGraphView.addGestureRecognizer(recentTap)
        
        let remoteTap = UITapGestureRecognizer(target: self, action: #selector(navigateToDetailView(_:)))
        remoteGraphView.addGestureRecognizer(remoteTap)
    }

    // MARK: - Navigation
    @objc private func navigateToDetailView(_ sender: UITapGestureRecognizer) {
        guard let tappedView = sender.view else { return }
        
       
        var detailViewController: UIViewController?
        
       
        switch tappedView.tag {
        case 1: // Daily Questions View
            detailViewController = DailyQuestionDetailViewController()
            detailViewController?.title = "Daily Questions"
        case 2: // Immediate Memory Details
            detailViewController = UIViewController() // Replace with Immediate Memory ViewController
            detailViewController?.view.backgroundColor = .white
            detailViewController?.title = "Immediate Memory Details"
        case 3: // Recent Memory Details
            detailViewController = UIViewController() // Replace with Recent Memory ViewController
            detailViewController?.view.backgroundColor = .white
            detailViewController?.title = "Recent Memory Details"
        case 4: // Remote Memory Details
            detailViewController = UIViewController() // Replace with Remote Memory ViewController
            detailViewController?.view.backgroundColor = .white
            detailViewController?.title = "Remote Memory Details"
        default:
            return
        }
        
        // Push the detail view controller if it's initialized
        if let detailVC = detailViewController {
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }

    
    @objc private func segmentedControlChanged(_ sender: UISegmentedControl) {
        immediateGraphView.isHidden = sender.selectedSegmentIndex != 0
        recentGraphView.isHidden = sender.selectedSegmentIndex != 1
        remoteGraphView.isHidden = sender.selectedSegmentIndex != 2
    }
}
