//
//  HomeViewController.swift
//  recap
//
//  Created by Diptayan Jash on 05/11/24.
//

import UIKit
import Foundation
import SDWebImage
class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupDelegates()
        setupLayout()
    }

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
        layout.itemSize = CGSize(width: (view.frame.width - 60) / 2, height: 200)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: "CardCell")
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private let activitiesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Activities"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ActivityCell.self, forCellReuseIdentifier: "ActivityCell")
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()

    private lazy var profileButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 28, weight: .medium)
        let image = UIImage(
            systemName: "person.circle.fill",
            withConfiguration: config
        )
        button.setImage(image, for: .normal)
        button.tintColor = .systemGreen
        button.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - needs to be fixed and checked
//    override func viewDidLayoutSubviews() {
//            super.viewDidLayoutSubviews()
//            let accessoryView = UIButton()
//            let image = UIImage(named:"avatar")
//
//            accessoryView.setImage(image, for: .normal)
//            accessoryView.frame.size = CGSize(width: 34, height: 34)
//            let largeTitleView = navigationController?.navigationBar.subviews.first { subview in
//                return String(describing: type(of: subview)) == "_UINavigationBarLargeTitleView"
//            }
//            largeTitleView?.perform (Selector(("setAccessoryView:")), with: accessoryView)
//            largeTitleView?.perform (Selector(("setAlignAccessoryViewToTitleBaseline:")), with: nil)
//            largeTitleView?.perform(Selector (("updateContent") ))
//        }
    
        // MARK: - This works
//    override func viewDidAppear(_ animated: Bool) {
//        let accessoryView = UIButton()
//        let image = UIImage(named:"dj")
//
//        accessoryView.setImage(image, for: .normal)
//        accessoryView.frame.size = CGSize(width: 34, height: 34)
//        accessoryView.clipsToBounds = true
//        accessoryView.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
//        let largeTitleView = navigationController?.navigationBar.subviews.first { subview in
//            return String(describing: type(of: subview)) == "_UINavigationBarLargeTitleView"
//        }
//        largeTitleView?.perform (Selector(("setAccessoryView:")), with: accessoryView)
//        largeTitleView?.perform (Selector(("setAlignAccessoryViewToTitleBaseline:")), with: nil)
//        largeTitleView?.perform(Selector (("updateContent") ))
//    }

    private func setupNavigationBar() {
        let profileBarButton = UIBarButtonItem(customView: profileButton)
        navigationItem.rightBarButtonItem = profileBarButton
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Home"
    }

    @objc private func profileButtonTapped() {
        let profileVC = ProfileViewController()
        let navController = UINavigationController(rootViewController: profileVC)
        present(navController, animated: true)
        
//        let userDetailsVC = patientInfo()
//        let nav = UINavigationController(rootViewController: userDetailsVC)
//        present(nav, animated: true)
        
//        let storyboard = UIStoryboard(name: "ProfileSection", bundle: nil)
//        if let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController2") as? ProfileViewController2 {
//            self.present(profileVC, animated: true, completion: nil)
//        }
    }

    private func setupLayout() {
        view.addSubview(collectionView)
        view.addSubview(activitiesTitleLabel)
        view.addSubview(tableView)
        GradientBackground()
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        activitiesTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 200),

            activitiesTitleLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 24),
            activitiesTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            activitiesTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            tableView.topAnchor.constraint(equalTo: activitiesTitleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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

    private func setupDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 164
    }
}

// MARK: - UICollectionViewDelegate and DataSource

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        
        if indexPath.item == 0 {
            cell.configure(with: "Questions", description: "Boost your memory by up to 20%", image: UIImage(named: "oldMan"))
        } else {
            cell.configure(with: "Streaks", description: "See how active you are", image: UIImage(named: "cosmonaut"))
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            if indexPath.item == 0 {
                let questionsVC = QuestionsViewController()
                self.navigationController?.pushViewController(questionsVC, animated: true)
            } else {
                let streaksVC = streaksViewController()
                self.navigationController?.pushViewController(streaksVC, animated: true)
            }
        }
    }
}

// MARK: - UITableViewDelegate and DataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityCell
        if indexPath.row == 0 {
            cell.configure(with: "Let's Read", description: "Reduces memory decline by 30%.", icon: UIImage(named: "BigShoesTorso"))
        } else {
            cell.configure(with: "Play a Game", description: "Helps you to reduce memory decline by 32%.", icon: UIImage(named: "Game"))
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            if indexPath.row == 0 {
                let letsReadVC = ArticleTableViewController()
                self.navigationController?.pushViewController(letsReadVC, animated: true)
            } else {
                let playGameVC = PlayGameViewController()
                self.navigationController?.pushViewController(playGameVC, animated: true)
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
#Preview()
{
    HomeViewController()
}
