//
//  FamilyViewController.swift
//  recap
//
//  Created by Diptayan Jash on 05/11/24.
//

import UIKit

class FamilyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var familyMembers: [FamilyMember] = []
    private var collectionView: UICollectionView!

    private var dataProtocol: FamilyStorageProtocol

    init(
        storage: FamilyStorageProtocol = UserDefaultsStorageFamilyMember.shared
    ) {
        dataProtocol = storage
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        dataProtocol = UserDefaultsStorageFamilyMember.shared
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Family"
        view.backgroundColor = .systemBackground

        setupUI()
        loadFamilyMembers()
        setupNotifications()
    }

    private func loadFamilyMembers() {
        familyMembers = dataProtocol.getFamilyMembers()
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleFamilyMemberAdded),
            name: Notification.Name("FamilyMemberAdded"),
            object: nil
        )
    }

    private func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        layout.itemSize = CGSize(width: 170, height: 226)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FamilyMemberCell.self, forCellWithReuseIdentifier: FamilyMemberCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true

        view.addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        GradientBackground()
        setupFloatingButton()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleFamilyMemberAdded),
            name: Notification.Name("FamilyMemberAdded"),
            object: nil
        )
    }

    @objc private func handleFamilyMemberAdded() {
        loadFamilyMembers()
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

    private func setupFloatingButton() {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 28, weight: .medium)
        let image = UIImage(systemName: "plus.circle.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)

        view.addSubview(button)

        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            button.widthAnchor.constraint(equalToConstant: 60),
            button.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    @objc private func didTapAdd() {
        print("Add button tapped")
        let AddFamily = AddFamilyMemberViewController()
        let navController = UINavigationController(rootViewController: AddFamily)
        if let sheet = navController.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
            sheet.prefersEdgeAttachedInCompactHeight = true
        }
        present(navController, animated: true, completion: nil)

        // FOR STORYBOARD METHOD
//        let storyboard = UIStoryboard(name: "AddFamily", bundle: nil)
//        if let profileVC = storyboard.instantiateViewController(withIdentifier: "AddFamilyMemberViewController2") as? AddFamilyMemberViewController2 {
//            let navigationController = UINavigationController(rootViewController: profileVC)
//            if let sheet = navigationController.sheetPresentationController {
//                sheet.detents = [.large()]
//                sheet.prefersGrabberVisible = true
//                sheet.prefersEdgeAttachedInCompactHeight = true
//            }
//            present(navigationController, animated: true, completion: nil)
//        }
    }

    // MARK: - Collection View Data Source

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return familyMembers.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMember = familyMembers[indexPath.row]
        let detailVC = FamilyMemberDetailViewController(member: selectedMember)
        let navController = UINavigationController(rootViewController: detailVC)

        if let sheet = navController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.prefersEdgeAttachedInCompactHeight = true
        }

        // PUSH STYLE
//        navigationController?.pushViewController(detailVC, animated: true)

        present(navController, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FamilyMemberCell.identifier, for: indexPath) as? FamilyMemberCell else {
            fatalError("Unable to dequeue FamilyMemberCell")
        }
        let member = familyMembers[indexPath.row]
        cell.configure(with: member)
        return cell
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFamilyMembers()
    }
}

#Preview() {
    FamilyViewController()
}
