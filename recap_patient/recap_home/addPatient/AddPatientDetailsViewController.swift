//
//  AddPatientDetailsViewController.swift
//  recap_home
//
//  Created by user@47 on 12/11/24.
//

import UIKit

class AddPatientDetailsViewController: UIViewController {
    
    // Properties
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Patient’s Details"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        return imageView
    }()
    
    private let firstNameTextField = CustomTextField(placeholder: "First Name")
    private let lastNameTextField = CustomTextField(placeholder: "Last Name")
    private let dobTextField = CustomTextField(placeholder: "DOB (DD/MM/YYYY)")
    private let sexTextField = CustomTextField(placeholder: "Sex")
    private let bloodGroupTextField = CustomTextField(placeholder: "Blood Group")
    private let relationTextField = CustomTextField(placeholder: "Relation")
    private let stageTextField = CustomTextField(placeholder: "Stage")
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupScrollView()
        
        // Add subviews to content view
        contentView.addSubview(titleLabel)
        contentView.addSubview(profileImageView)
        contentView.addSubview(firstNameTextField)
        contentView.addSubview(lastNameTextField)
        contentView.addSubview(dobTextField)
        contentView.addSubview(sexTextField)
        contentView.addSubview(bloodGroupTextField)
        contentView.addSubview(relationTextField)
        contentView.addSubview(stageTextField)
        contentView.addSubview(saveButton)
        
        // Layout
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        dobTextField.translatesAutoresizingMaskIntoConstraints = false
        sexTextField.translatesAutoresizingMaskIntoConstraints = false
        bloodGroupTextField.translatesAutoresizingMaskIntoConstraints = false
        relationTextField.translatesAutoresizingMaskIntoConstraints = false
        stageTextField.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            profileImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            firstNameTextField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            firstNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            firstNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 15),
            lastNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            lastNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            dobTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 15),
            dobTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dobTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            sexTextField.topAnchor.constraint(equalTo: dobTextField.bottomAnchor, constant: 15),
            sexTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            sexTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            bloodGroupTextField.topAnchor.constraint(equalTo: sexTextField.bottomAnchor, constant: 15),
            bloodGroupTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            bloodGroupTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            relationTextField.topAnchor.constraint(equalTo: bloodGroupTextField.bottomAnchor, constant: 15),
            relationTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            relationTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            stageTextField.topAnchor.constraint(equalTo: relationTextField.bottomAnchor, constant: 15),
            stageTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stageTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            saveButton.topAnchor.constraint(equalTo: stageTextField.bottomAnchor, constant: 30),
            saveButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    @objc private func saveButtonTapped() {
        let interestsVC = InterestsSelectionViewController()
        interestsVC.modalPresentationStyle = .fullScreen
        self.present(interestsVC, animated: true, completion: nil)
        navigationController?.pushViewController(interestsVC, animated: true)
    }
}

class CustomTextField: UIView {
    private let textField = UITextField()
    
    init(placeholder: String) {
        super.init(frame: .zero)
        
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        clearButton.tintColor = .gray
        clearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
        
        addSubview(textField)
        addSubview(clearButton)
        
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            clearButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 5),
            clearButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            clearButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textField.trailingAnchor.constraint(equalTo: clearButton.leadingAnchor, constant: -5),
            textField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9)
        ])
    }
    
    @objc private func clearText() {
        textField.text = ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#Preview() {
    AddPatientDetailsViewController()
}
