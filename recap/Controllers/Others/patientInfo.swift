import UIKit

class patientInfo: UIViewController {
    
    // MARK: - UI Components
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray6
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.tintColor = .systemGray
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = 50
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let firstNameField = CustomTextField(placeholder: "First Name")
    private let lastNameField = CustomTextField(placeholder: "Last Name")
    private let dobField = CustomTextField(placeholder: "Date of Birth")
    private let sexField = CustomTextField(placeholder: "Sex")
    private let bloodGroupField = CustomTextField(placeholder: "Blood Group")
    private let stageField = CustomTextField(placeholder: "Stage")
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        return button
    }()
    
    // MARK: - Properties
    private let imagePicker = UIImagePickerController()
    private let datePicker = UIDatePicker()
    private let sexPicker = UIPickerView()
    private let bloodGroupPicker = UIPickerView()
    private let stagePicker = UIPickerView()
    
    let sexOptions = SexOptions.allCases.map { $0.rawValue }
    let bloodGroupOptions = BloodGroupOptions.allCases.map { $0.rawValue }
    let stageOptions = StageOptions.allCases.map { $0.rawValue }

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        setupImagePicker()
        setupPickers()
        setupTextFields()
    }
    
    // MARK: - Setup
    private func setupNavigationBar() {
        title = "Add Details"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Skip",
            style: .plain,
            target: self,
            action: #selector(skipButtonTapped)
        )
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Add subviews
        [profileImageView, stackView, saveButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        // Add text fields to stack
        [firstNameField, lastNameField, dobField, sexField, bloodGroupField, stageField].forEach {
            stackView.addArrangedSubview($0)
        }
        
        // Layout constraints
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            stackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Add tap gesture to profile image
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImageView.addGestureRecognizer(tapGesture)
        
        // Add targets
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    private func setupImagePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
    }
    
    private func setupTextFields() {
        // Make text fields non-editable since we're using pickers
        dobField.isUserInteractionEnabled = true
        sexField.isUserInteractionEnabled = true
        bloodGroupField.isUserInteractionEnabled = true
        stageField.isUserInteractionEnabled = true
        
        // Optional: Add any additional text field customization
        firstNameField.autocapitalizationType = .words
        lastNameField.autocapitalizationType = .words
        
        // Prevent keyboard from showing up for picker fields
        dobField.inputView = datePicker
        sexField.inputView = sexPicker
        bloodGroupField.inputView = bloodGroupPicker
        stageField.inputView = stagePicker
    }
    
    private func setupPickers() {
        // Date Picker
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
        dobField.inputView = datePicker
        
        // Sex Picker
        sexPicker.delegate = self
        sexPicker.dataSource = self
        sexField.inputView = sexPicker
        
        // Blood Group Picker
        bloodGroupPicker.delegate = self
        bloodGroupPicker.dataSource = self
        bloodGroupField.inputView = bloodGroupPicker
        
        // Stage Picker
        stagePicker.delegate = self
        stagePicker.dataSource = self
        stageField.inputView = stagePicker
        
        // Add toolbar with Done button to all pickers
        [dobField, sexField, bloodGroupField, stageField].forEach {
            $0.inputAccessoryView = createToolbar()
        }
    }
    
    private func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(dismissPicker)
        )
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexSpace, doneButton], animated: false)
        
        return toolbar
    }
    
    // MARK: - Actions
    @objc private func datePickerChanged() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dobField.text = formatter.string(from: datePicker.date)
    }
    
    @objc private func dismissPicker() {
        view.endEditing(true)
    }
    
    @objc private func profileImageTapped() {
        present(imagePicker, animated: true)
    }
    
    @objc private func saveButtonTapped() {
        // Validate inputs
        guard let firstName = firstNameField.text, !firstName.isEmpty,
              let lastName = lastNameField.text, !lastName.isEmpty,
              let dob = dobField.text, !dob.isEmpty,
              let sex = sexField.text, !sex.isEmpty,
              let bloodGroup = bloodGroupField.text, !bloodGroup.isEmpty,
              let stage = stageField.text, !stage.isEmpty else {
            showAlert(message: "Please fill in all fields")
            return
        }
        
        // Save user details to Firebase or local storage
        let PatientDetails = UserDetails(
            firstName: firstName,
            lastName: lastName,
            dateOfBirth: dob,
            sex: sex,
            bloodGroup: bloodGroup,
            stage: stage
        )
        
        // TODO: Save to Firebase
        FirebaseManager.shared.saveUserProfile(PatientDetails) { [weak self] error in
            if let error = error {
                self?.showAlert(message: error.localizedDescription)
            } else {
                self?.dismiss(animated: true)
            }
        }
        
        // Dismiss view
        dismiss(animated: true)
    }
    
    @objc private func skipButtonTapped() {
        dismiss(animated: true)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension patientInfo: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            profileImageView.image = image
        }
        picker.dismiss(animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension patientInfo: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Add validation logic for DOB, sex, and blood group if needed
        return true
    }
}

// MARK: - UIPickerViewDelegate & DataSource
extension patientInfo: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case sexPicker:
            return sexOptions.count
        case bloodGroupPicker:
            return bloodGroupOptions.count
        case stagePicker:
            return stageOptions.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case sexPicker:
            return sexOptions[row]
        case bloodGroupPicker:
            return bloodGroupOptions[row]
        case stagePicker:
            return stageOptions[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case sexPicker:
            if let selectedSex = SexOptions(rawValue: sexOptions[row]) {
                sexField.text = selectedSex.rawValue
            }
        case bloodGroupPicker:
            if let selectedBloodGroup = BloodGroupOptions(rawValue: bloodGroupOptions[row]) {
                bloodGroupField.text = selectedBloodGroup.rawValue
            }
        case stagePicker:
            if let selectedStage = StageOptions(rawValue: stageOptions[row]) {
                stageField.text = selectedStage.rawValue
            }
        default:
            break
        }
    }

}

// MARK: - Custom TextField
class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        self.placeholder = placeholder
    }
    
    private func setup() {
        backgroundColor = .systemGray6
        layer.cornerRadius = 8
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        leftViewMode = .always
        heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
} 
