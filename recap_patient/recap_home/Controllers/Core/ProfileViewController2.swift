//
//  ProfileViewController2.swift
//  recap
//
//  Created by Diptayan Jash on 011/11/24.
//

import UIKit

class ProfileViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    @IBOutlet weak var profileImageView: UIImageView!
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupUI()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        // Add a visible "Close" button with a contrasting color
        let doneButton = UIBarButtonItem(
            title: "Close",
            style: .done,
            target: self,
            action: #selector(doneButtonTapped)
        )
        navigationItem.rightBarButtonItem = doneButton
        
        // Ensure the button is visible when presented as a sheet
        if let sheet = self.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.prefersEdgeAttachedInCompactHeight = true
        }
    }
    
    @objc private func doneButtonTapped() {
        dismiss(animated: true)
    }
    
    private func setupUI() {
        // Set up profileImageView properties
        profileImageView.image = UIImage(systemName: "person.circle")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        
        // Set up nameLabel properties
        nameLabel.text = "John Doe"
        nameLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        nameLabel.textAlignment = .center
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    // MARK: - UITableViewDelegate & DataSource Methods
    
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
            
        case 1:
            cell.textLabel?.text = "Memory Check Results"
            cell.detailTextLabel?.text = "Last check: Today"
            cell.imageView?.image = UIImage(systemName: "brain.head.profile")
            cell.imageView?.tintColor = .systemGreen
            
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
