//
//  AddQuestionViewController.swift
//  Recap
//
//  Created by admin70 on 09/11/24.
//

#Preview(){
    AddQuestionViewController()
}


import UIKit

class AddQuestionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let questionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "What did you eat?"
        textField.backgroundColor = UIColor.systemGray6
        textField.layer.cornerRadius = 10
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 26)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.systemGray5
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true // Initially hidden
        return imageView
    }()
    
    private let addImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Image", for: .normal)
        button.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let optionButtons: [UIButton] = ["Rice", "Chapatti", "Aloo Paratha", "Poha"].map { title in
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = UIColor.systemGray6
        button.setTitleColor(.gray, for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveQuestion), for: .touchUpInside)
        return button
    }()
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Add Question"
        
        setupLayout()
        setupButtonActions()
        
        addImageButton.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
    }
    
    private func setupLayout() {
        view.addSubview(questionTextField)
        view.addSubview(imageView)
        view.addSubview(addImageButton)
        for button in optionButtons {
            view.addSubview(button)
        }
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            questionTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            questionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            questionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            questionTextField.heightAnchor.constraint(equalToConstant: 50),
            
            imageView.topAnchor.constraint(equalTo: questionTextField.bottomAnchor, constant: 0), // No gap initially
            imageView.leadingAnchor.constraint(equalTo: questionTextField.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: questionTextField.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            addImageButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10), // Space appears only after image is added
            addImageButton.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            addImageButton.heightAnchor.constraint(equalToConstant: 40),
            addImageButton.widthAnchor.constraint(equalToConstant: 120),
            
            optionButtons[0].topAnchor.constraint(equalTo: addImageButton.bottomAnchor, constant: 30),
            optionButtons[0].leadingAnchor.constraint(equalTo: questionTextField.leadingAnchor),
            optionButtons[0].widthAnchor.constraint(equalToConstant: 150),
            optionButtons[0].heightAnchor.constraint(equalToConstant: 60),
            
            optionButtons[1].topAnchor.constraint(equalTo: addImageButton.bottomAnchor, constant: 30),
            optionButtons[1].trailingAnchor.constraint(equalTo: questionTextField.trailingAnchor),
            optionButtons[1].widthAnchor.constraint(equalToConstant: 150),
            optionButtons[1].heightAnchor.constraint(equalToConstant: 60),
            
            optionButtons[2].topAnchor.constraint(equalTo: optionButtons[0].bottomAnchor, constant: 30),
            optionButtons[2].leadingAnchor.constraint(equalTo: questionTextField.leadingAnchor),
            optionButtons[2].widthAnchor.constraint(equalToConstant: 150),
            optionButtons[2].heightAnchor.constraint(equalToConstant: 60),
            
            optionButtons[3].topAnchor.constraint(equalTo: optionButtons[1].bottomAnchor, constant: 30),
            optionButtons[3].trailingAnchor.constraint(equalTo: questionTextField.trailingAnchor),
            optionButtons[3].widthAnchor.constraint(equalToConstant: 150),
            optionButtons[3].heightAnchor.constraint(equalToConstant: 60),
            
            saveButton.topAnchor.constraint(equalTo: optionButtons[2].bottomAnchor, constant: 80),
            saveButton.leadingAnchor.constraint(equalTo: questionTextField.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: questionTextField.trailingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupButtonActions() {
        for button in optionButtons {
            button.addTarget(self, action: #selector(editButtonTitle(_:)), for: .touchUpInside)
        }
    }
    
    @objc private func selectImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
            imageView.isHidden = false
            image = selectedImage
            updateLayoutForImage() 
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func updateLayoutForImage() {
        // Remove space between the text field and the image view
        NSLayoutConstraint.deactivate([
            imageView.topAnchor.constraint(equalTo: questionTextField.bottomAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: questionTextField.bottomAnchor, constant: 0) // Adjust top constraint after image is added
        ])
    }
    
    @objc private func editButtonTitle(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Edit Option", message: "Enter a new title for this option", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "New title"
            textField.text = sender.title(for: .normal)
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            if let newTitle = alertController.textFields?.first?.text, !newTitle.isEmpty {
                sender.setTitle(newTitle, for: .normal)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func saveQuestion() {
        guard let title = questionTextField.text, !title.isEmpty else {
            // Show an alert if title is empty
            let alert = UIAlertController(title: "Error", message: "Please enter a question title", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let options = optionButtons.map { $0.title(for: .normal) ?? "" }
        let newQuestion = Question(title: title, options: options, image: imageView.image?.description)
        
        // Save the new question
        QuestionData.append(newQuestion)
        
        // Notify the DailyQuestionDetailViewController to reload the data
        NotificationCenter.default.post(name: Notification.Name("reloadData"), object: nil)
        
        dismiss(animated: true, completion: nil)
    }
}


//
//import UIKit
//
//class AddQuestionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    
//    private let questionTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "What did you eat?"
//        textField.backgroundColor = UIColor.systemGray6
//        textField.layer.cornerRadius = 10
//        textField.textAlignment = .center
//        textField.font = UIFont.systemFont(ofSize: 26)
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        return textField
//    }()
//    
//    private let imageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.backgroundColor = UIColor.systemGray5
//        imageView.layer.cornerRadius = 10
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//    
//    private let addImageButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Add Image", for: .normal)
//        button.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
//        button.setTitleColor(.black, for: .normal)
//        button.layer.cornerRadius = 10
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    private let optionButtons: [UIButton] = ["Rice", "Chapatti", "Aloo Paratha", "Poha"].map { title in
//        let button = UIButton(type: .system)
//        button.setTitle(title, for: .normal)
//        button.backgroundColor = UIColor.systemGray6
//        button.setTitleColor(.gray, for: .normal)
//        button.layer.cornerRadius = 10
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }
//    
//    private let saveButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Save", for: .normal)
//        button.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
//        button.setTitleColor(.black, for: .normal)
//        button.layer.cornerRadius = 10
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(self, action: #selector(saveQuestion), for: .touchUpInside)
//        return button
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        title = "Add Question"
//        navigationController?.navigationBar.titleTextAttributes = [
//            .font: UIFont.boldSystemFont(ofSize: 24)
//        ]
//        
//        setupLayout()
//        setupButtonActions()
//        
//        addImageButton.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
//    }
//    
//    private func setupLayout() {
//        view.addSubview(questionTextField)
//        view.addSubview(imageView)
//        view.addSubview(addImageButton)
//        for button in optionButtons {
//            view.addSubview(button)
//        }
//        view.addSubview(saveButton)
//        
//        NSLayoutConstraint.activate([
//            questionTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
//            questionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
//            questionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            questionTextField.heightAnchor.constraint(equalToConstant: 50),
//            
//            imageView.topAnchor.constraint(equalTo: questionTextField.bottomAnchor, constant: 20),
//            imageView.leadingAnchor.constraint(equalTo: questionTextField.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: questionTextField.trailingAnchor),
//            imageView.heightAnchor.constraint(equalToConstant: 200),
//            
//            addImageButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
//            addImageButton.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
//            addImageButton.heightAnchor.constraint(equalToConstant: 40),
//            addImageButton.widthAnchor.constraint(equalToConstant: 120),
//            
//            optionButtons[0].topAnchor.constraint(equalTo: addImageButton.bottomAnchor, constant: 30),
//            optionButtons[0].leadingAnchor.constraint(equalTo: questionTextField.leadingAnchor),
//            optionButtons[0].widthAnchor.constraint(equalToConstant: 150),
//            optionButtons[0].heightAnchor.constraint(equalToConstant: 60),
//            
//            optionButtons[1].topAnchor.constraint(equalTo: addImageButton.bottomAnchor, constant: 30),
//            optionButtons[1].trailingAnchor.constraint(equalTo: questionTextField.trailingAnchor),
//            optionButtons[1].widthAnchor.constraint(equalToConstant: 150),
//            optionButtons[1].heightAnchor.constraint(equalToConstant: 60),
//            
//            optionButtons[2].topAnchor.constraint(equalTo: optionButtons[0].bottomAnchor, constant: 30),
//            optionButtons[2].leadingAnchor.constraint(equalTo: questionTextField.leadingAnchor),
//            optionButtons[2].widthAnchor.constraint(equalToConstant: 150),
//            optionButtons[2].heightAnchor.constraint(equalToConstant: 60),
//            
//            optionButtons[3].topAnchor.constraint(equalTo: optionButtons[1].bottomAnchor, constant: 30),
//            optionButtons[3].trailingAnchor.constraint(equalTo: questionTextField.trailingAnchor),
//            optionButtons[3].widthAnchor.constraint(equalToConstant: 150),
//            optionButtons[3].heightAnchor.constraint(equalToConstant: 60),
//            
//            saveButton.topAnchor.constraint(equalTo: optionButtons[2].bottomAnchor, constant: 80),
//            saveButton.leadingAnchor.constraint(equalTo: questionTextField.leadingAnchor),
//            saveButton.trailingAnchor.constraint(equalTo: questionTextField.trailingAnchor),
//            saveButton.heightAnchor.constraint(equalToConstant: 50)
//        ])
//    }
//    
//    private func setupButtonActions() {
//        for button in optionButtons {
//            button.addTarget(self, action: #selector(editButtonTitle(_:)), for: .touchUpInside)
//        }
//    }
//    
//    @objc private func selectImage() {
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = .photoLibrary
//        present(imagePicker, animated: true, completion: nil)
//    }
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        picker.dismiss(animated: true, completion: nil)
//        if let selectedImage = info[.originalImage] as? UIImage {
//            imageView.image = selectedImage
//        }
//    }
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
//    
//    @objc private func editButtonTitle(_ sender: UIButton) {
//        let alertController = UIAlertController(title: "Edit Option", message: "Enter a new title for this option", preferredStyle: .alert)
//        alertController.addTextField { textField in
//            textField.placeholder = "New title"
//            textField.text = sender.title(for: .normal)
//        }
//        
//        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
//            if let newTitle = alertController.textFields?.first?.text, !newTitle.isEmpty {
//                sender.setTitle(newTitle, for: .normal)
//            }
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        
//        alertController.addAction(saveAction)
//        alertController.addAction(cancelAction)
//        
//        present(alertController, animated: true, completion: nil)
//    }
//    
//    @objc private func saveQuestion() {
//        guard let title = questionTextField.text, !title.isEmpty else {
//            // Handle missing question title
//            let alert = UIAlertController(title: "Error", message: "Please enter a valid question title.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            present(alert, animated: true, completion: nil)
//            return
//        }
//        
//        let options = optionButtons.map { $0.title(for: .normal) ?? "" }
//        let newQuestion = Question(title: title, options: options, image: imageView.image?.description)
//        
//        // Save the new question
//        QuestionData.append(newQuestion)
//        
//        // Notify the DailyQuestionDetailViewController to reload the data
//        NotificationCenter.default.post(name: Notification.Name("reloadData"), object: nil)
//        
//        dismiss(animated: true, completion: nil)
//    }
//}
//
