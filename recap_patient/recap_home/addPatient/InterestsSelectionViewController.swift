//
//  InterestsSelectionViewController.swift
//  recap_home
//
//  Created by user@47 on 12/11/24.
//

import UIKit

class InterestsSelectionViewController: UIViewController {
    
    private let interests = [
        "Museums", "Baking", "Cats", "Vegetarian", "Writing", "Art", "Yoga",
        "Music", "Gardening", "Festivals", "Movies", "Dogs", "Foodie", "Camping",
        "City breaks", "Coffee", "Wine", "Hiking", "Dancing", "Tennis"
    ]
    
    private var selectedInterests: Set<String> = []
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose 5 things you are really into"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "What are you into?"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let interestsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 15
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = "0/5 selected"
        label.textAlignment = .center
        return label
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        let configuration = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold)
        button.setImage(UIImage(systemName: "arrow.right.circle.fill", withConfiguration: configuration), for: .normal)
        button.tintColor = .blue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        interestsCollectionView.delegate = self
        interestsCollectionView.dataSource = self
        interestsCollectionView.register(InterestCell.self, forCellWithReuseIdentifier: InterestCell.identifier)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(titleLabel)
        view.addSubview(searchTextField)
        view.addSubview(interestsCollectionView)
        view.addSubview(skipButton)
        view.addSubview(countLabel)
        view.addSubview(nextButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        interestsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            searchTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            interestsCollectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            interestsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            interestsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            interestsCollectionView.bottomAnchor.constraint(equalTo: countLabel.topAnchor, constant: -20),
            
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            countLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc private func skipButtonTapped() {
        let tabbarVC = tabbarViewController()
        tabbarVC.modalPresentationStyle = .fullScreen
        self.present(tabbarVC, animated: true, completion: nil)
        navigationController?.pushViewController(tabbarVC, animated: true)
    }
    
    @objc private func nextButtonTapped() {
        let tabbarVC = tabbarViewController()
        tabbarVC.modalPresentationStyle = .fullScreen
        self.present(tabbarVC, animated: true, completion: nil)
        navigationController?.pushViewController(tabbarVC, animated: true)
    }
    
    private func updateSelectedCount() {
        countLabel.text = "\(selectedInterests.count)/5 selected"
    }
}

extension InterestsSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestCell.identifier, for: indexPath) as? InterestCell else {
            return UICollectionViewCell()
        }
        
        let interest = interests[indexPath.item]
        let isSelected = selectedInterests.contains(interest)
        cell.configure(with: interest, isSelected: isSelected)
        
        cell.onSelect = { [weak self] in
            guard let self = self else { return }
            if isSelected {
                self.selectedInterests.remove(interest)
            } else if self.selectedInterests.count < 5 {
                self.selectedInterests.insert(interest)
            }
            self.updateSelectedCount()
            collectionView.reloadItems(at: [indexPath])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 3
        return CGSize(width: width, height: 40)
    }
}

class InterestCell: UICollectionViewCell {
    static let identifier = "InterestCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    var onSelect: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.backgroundColor = .systemBackground
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        contentView.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with interest: String, isSelected: Bool) {
        label.text = interest
        contentView.backgroundColor = isSelected ? UIColor.blue.withAlphaComponent(0.2) : .clear
        contentView.layer.borderColor = isSelected ? UIColor.blue.cgColor : UIColor.gray.cgColor
    }
    
    @objc private func didTap() {
        onSelect?()
    }
}

#Preview() {
    InterestsSelectionViewController()
}
