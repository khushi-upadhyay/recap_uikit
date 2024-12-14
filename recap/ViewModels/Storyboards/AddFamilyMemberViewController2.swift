//
//  AddFamilyMemberViewController2.swift
//  recap
//
//  Created by Diptayan Jash on 12/11/24.
//

import UIKit
import PhotosUI

class AddFamilyMemberViewController2: UIViewController {
    
    private let relationshipOptions = RelationshipCategory.allCases
    private let relationshipPicker = UIPickerView()
    private let pickerToolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        return toolbar
    }()
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var addPhotoButton: UIButton!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var relationshipTextField: UITextField!
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(dismissKeyboardTap)
        
        realtionshipPicker()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped(_:)))
        profileImageView.addGestureRecognizer(tapGesture)
        profileImageView.layer.cornerRadius = 50
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(dismissView))
        
        nameTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
            relationshipTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
            phoneTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
            emailTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func realtionshipPicker() {
        relationshipPicker.delegate = self
        relationshipPicker.dataSource = self
        relationshipTextField.inputView = relationshipPicker
        
        // Toolbar for the picker view
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePickingRelationship))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        pickerToolbar.setItems([flexibleSpace, doneButton], animated: false)
        
        relationshipTextField.inputAccessoryView = pickerToolbar
    }
    
    @objc private func donePickingRelationship() {
        let selectedRow = relationshipPicker.selectedRow(inComponent: 0)
        let selectedRelationship = relationshipOptions[selectedRow]
        relationshipTextField.text = selectedRelationship.rawValue
        relationshipTextField.resignFirstResponder()
    }
    
    @IBAction private func addButtonTapped(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty,
              let relationship = relationshipTextField.text, !relationship.isEmpty,
              let phone = phoneTextField.text, !phone.isEmpty,
              let email = emailTextField.text, !email.isEmpty else {
            let alert = UIAlertController(
                title: "Missing Information",
                message: "Please fill in all fields",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        let newMember = FamilyMember(
            name: name,
            relationship: relationship,
            phone: phone,
            email: email,
            imageName: "familyImg",
            imageURL: "https://as1.ftcdn.net/v2/jpg/02/99/04/20/1000_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg"
        )
        
        familyMembers.append(newMember)
        
        NotificationCenter.default.post(
            name: Notification.Name("FamilyMemberAdded"),
            object: nil
        )
        
        let alert = UIAlertController(
            title: "Success",
            message: "Family member added successfully",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.dismiss(animated: true)
        })
        present(alert, animated: true)
    }

    @IBAction private func profileImageTapped(_ sender: UIButton) {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }

    @IBAction private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction private func dismissView() {
        dismiss(animated: true)
    }
}

// MARK: - PHPickerViewControllerDelegate
extension AddFamilyMemberViewController2: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let result = results.first else { return }
        
        result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
            if let image = image as? UIImage {
                DispatchQueue.main.async {
                    self?.profileImageView.image = image
                }
            }
        }
    }
}

// MARK: - UIPickerViewDelegate & UIPickerViewDataSource
extension AddFamilyMemberViewController2: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return relationshipOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return relationshipOptions[row].rawValue
    }
}
