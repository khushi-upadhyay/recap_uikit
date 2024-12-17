import PhotosUI
import UIKit

class AddFamilyMemberViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    private var selectedImage: UIImage?
    
    private var storage: FamilyStorageProtocol

    init(
        storage: FamilyStorageProtocol = UserDefaultsStorageFamilyMember.shared
    ) {
        self.storage = storage
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        storage = UserDefaultsStorageFamilyMember.shared
        super.init(coder: coder)
    }

    private let relationshipOptions = RelationshipCategory.allCases
    private let relationshipPicker = UIPickerView()
    private let pickerToolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        return toolbar
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        return view
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray6
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.tintColor = .systemGray3
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    private let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Photo", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        return button
    }()

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Full Name"
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 17)
        return textField
    }()

    private let relationshipTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Relationship (e.g., Son, Daughter)"
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 17)
        return textField
    }()

    private let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Phone Number"
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 17)
        textField.keyboardType = .phonePad
        return textField
    }()

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 17)
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        return textField
    }()

    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Family Member", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
        button.setTitleColor(.systemGreen, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGestures()
        setupRelationshipPicker()

        let doneButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(closeButtonTapped))
        navigationItem.rightBarButtonItem = doneButton
        if let sheet = sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.prefersEdgeAttachedInCompactHeight = true
        }

        let Dismisskeyboard = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(Dismisskeyboard)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Add Family Member"

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        [scrollView, contentView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        [profileImageView, addPhotoButton, nameTextField, relationshipTextField,
         phoneTextField, emailTextField, addButton].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        profileImageView.layer.cornerRadius = 50

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),

            addPhotoButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12),
            addPhotoButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            nameTextField.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 24),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            nameTextField.heightAnchor.constraint(equalToConstant: 44),

            relationshipTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            relationshipTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            relationshipTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            relationshipTextField.heightAnchor.constraint(equalToConstant: 44),

            phoneTextField.topAnchor.constraint(equalTo: relationshipTextField.bottomAnchor, constant: 16),
            phoneTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            phoneTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            phoneTextField.heightAnchor.constraint(equalToConstant: 44),

            emailTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 16),
            emailTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),

            addButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 32),
            addButton.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            addButton.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
        ])
    }

    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImageView.addGestureRecognizer(tapGesture)

        addPhotoButton.addTarget(self, action: #selector(profileImageTapped), for: .touchUpInside)
    }

    private func setupRelationshipPicker() {
        relationshipPicker.delegate = self
        relationshipPicker.dataSource = self
        relationshipTextField.inputView = relationshipPicker
        relationshipTextField.inputAccessoryView = pickerToolbar

        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePickingRelationship))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        pickerToolbar.setItems([flexibleSpace, doneButton], animated: false)
    }

    @objc private func donePickingRelationship() {
        let selectedRow = relationshipPicker.selectedRow(inComponent: 0)
        let selectedRelationship = relationshipOptions[selectedRow]
        relationshipTextField.text = selectedRelationship.rawValue
        relationshipTextField.resignFirstResponder()
    }

    @objc private func profileImageTapped() {
//        var config = PHPickerConfiguration()
//        config.selectionLimit = 1
//        config.filter = .images

//        let picker = PHPickerViewController(configuration: config)
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
//        picker.delegate = self
        present(picker, animated: true)
    }

    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }

    @objc private func addButtonTapped() {
        guard let name = nameTextField.text, !name.isEmpty,
              let relationship = relationshipTextField.text, !relationship.isEmpty,
              let phone = phoneTextField.text, !phone.isEmpty,
              let email = emailTextField.text, !email.isEmpty else {
            showAlert(title: "Missing Information", message: "Please fill in all fields")
            return
        }

        let newMember = FamilyMember(
            name: name,
            relationship: relationship,
            phone: phone,
            email: email,
            imageName: "",
            imageURL: ""
        )

        storage.saveFamilyMember(newMember, image: profileImageView.image) { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    NotificationCenter.default.post(name: Notification.Name("FamilyMemberAdded"), object: nil)
                    self?.showAlert(title: "Success", message: "member added successfully")
                } else {
                    self?.showAlert(title: "Error", message: "Failed to save family member")
                }
            }
        }
    }
}

// MARK: - PHPickerViewControllerDelegate

extension AddFamilyMemberViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        guard let result = results.first else { return }

        result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
            if let image = image as? UIImage {
                DispatchQueue.main.async {
                    self?.profileImageView.image = image
                }
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let editedImage = info[.editedImage] as? UIImage {
            profileImageView.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            profileImageView.image = originalImage
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

// MARK: - UIPickerViewDelegate & UIPickerViewDataSource

extension AddFamilyMemberViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
