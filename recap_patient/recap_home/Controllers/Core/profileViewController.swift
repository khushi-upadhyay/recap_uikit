//
//  ProfileViewController.swift
//  recap
//
//  Created by Diptayan Jash on 11/11/24.
//
import Foundation
import UIKit

class profileViewController: UIViewController {
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profileImg")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.widthAnchor.constraint(equalToConstant: 95).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 95).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "John Doe"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navBar()
        setupUI()
        setupTableView()
    }
    
    private func navBar() {
        navigationItem.largeTitleDisplayMode = .never
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped)
        )
        navigationItem.rightBarButtonItem = doneButton
        
        if let sheet = self.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.detents = [.medium(), .large()]
        }
    }
    
    @objc private func doneButtonTapped() {
        dismiss(animated: true)
    }
    
    private func setupUI() {
        [profileImageView, nameLabel, tableView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        profileImageView.layer.cornerRadius = 50
        profileImageView.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 95),
            profileImageView.heightAnchor.constraint(equalToConstant: 95),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

// MARK: - UITableViewDelegate & DataSource
extension profileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 6
        case 1: return 1
        case 2: return 1
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        if indexPath.section == 1 {
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.accessoryType = .none
        }
        
        switch indexPath.section {
        case 0:
            let titles = [
                "First Name",
                "Last Name",
                "Date of Birth",
                "Sex",
                "Age",
                "Blood Type"
            ]
            let values = [
                "John",
                "Doe",
                "01/01/1950",
                "Male",
                "74",
                "O+"
            ]
            
            cell.textLabel?.text = titles[indexPath.row]
            cell.detailTextLabel?.text = values[indexPath.row]
            cell.textLabel?.font = .systemFont(ofSize: 17)
            cell.selectionStyle = .none
            
        case 1:
            cell.textLabel?.text = "Memory Check Results"
            cell.detailTextLabel?.text = "Last check: Today"
            cell.imageView?.image = UIImage(systemName: "brain.head.profile")
            cell.imageView?.tintColor = .systemGreen
            cell.selectionStyle = .default
            
        case 2:
            cell.textLabel?.text = "Logout"
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = .boldSystemFont(ofSize: 17)
            cell.backgroundColor = .systemRed
            cell.textLabel?.textAlignment = .center
            cell.selectionStyle = .default
            
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 2 {
            logoutTapped()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Personal Information"
        case 1: return "Health"
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 0: return "This information helps us personalize your experience."
        case 1: return "Regular memory checks help track your progress."
        default: return nil
        }
    }
    
    @objc private func logoutTapped() {
        print("Logged out")
        dismiss(animated: true)
    }
}
