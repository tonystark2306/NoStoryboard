// InformationViewController.swift
import UIKit

class InformationViewController: UIViewController {
    
    // Data properties
    var userData: UserData?
    var onDataUpdated: ((UserData) -> Void)?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "First name"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Last name"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.text = "John"
        textField.placeholder = "Enter first name"
        textField.borderStyle = .none
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // Add padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.text = "Wick"
        textField.placeholder = "Enter last name"
        textField.borderStyle = .none
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // Add padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Gender"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genderSegmentedControl: UISegmentedControl = {
        let items = ["Male", "Female"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .white
        segmentedControl.selectedSegmentTintColor = UIColor(red: 0.9, green: 0.9, blue: 1.0, alpha: 1.0)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        segmentedControl.layer.cornerRadius = 8
        segmentedControl.layer.borderWidth = 1
        segmentedControl.layer.borderColor = UIColor.lightGray.cgColor
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    private let weightLabel: UILabel = {
        let label = UILabel()
        label.text = "Weight"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let heightLabel: UILabel = {
        let label = UILabel()
        label.text = "Height"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weightTextField: UITextField = {
        let textField = UITextField()
        textField.text = "86"
        textField.placeholder = "kg"
        textField.borderStyle = .none
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // Add padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private let heightTextField: UITextField = {
        let textField = UITextField()
        textField.text = "190"
        textField.placeholder = "cm"
        textField.borderStyle = .none
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // Add padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private let ageTextField: UITextField = {
        let textField = UITextField()
        textField.text = "28"
        textField.borderStyle = .none
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isHidden = true
        
        // Add padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private let updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Update", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 1.0, green: 0.4, blue: 0.4, alpha: 1.0)
        button.layer.cornerRadius = 25
        button.isEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var selectedGender: String = "Male"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        setupSampleData()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        title = "Information"
        
        // Setup navigation bar
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .medium)
        ]
        
        // Add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        view.addSubview(updateButton)
        
        contentView.addSubview(firstNameLabel)
        contentView.addSubview(lastNameLabel)
        contentView.addSubview(firstNameTextField)
        contentView.addSubview(lastNameTextField)
        contentView.addSubview(genderLabel)
        contentView.addSubview(genderSegmentedControl)
        contentView.addSubview(weightLabel)
        contentView.addSubview(heightLabel)
        contentView.addSubview(weightTextField)
        contentView.addSubview(heightTextField)
        contentView.addSubview(ageTextField)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Scroll View
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: updateButton.topAnchor, constant: -10),
            
            // Content View
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // First Name Label
            firstNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            firstNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            // Last Name Label - căn chỉnh với Last Name TextField
            lastNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            lastNameLabel.leadingAnchor.constraint(equalTo: lastNameTextField.leadingAnchor),
            
            // First Name TextField
            firstNameTextField.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 8),
            firstNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            firstNameTextField.widthAnchor.constraint(equalToConstant: 150),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 45),
            
            // Last Name TextField
            lastNameTextField.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 8),
            lastNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            lastNameTextField.widthAnchor.constraint(equalToConstant: 150),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 45),
            
            // Gender Label
            genderLabel.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 30),
            genderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            // Gender Segmented Control
            genderSegmentedControl.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 8),
            genderSegmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            genderSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            genderSegmentedControl.heightAnchor.constraint(equalToConstant: 45),
            
            // Weight Label
            weightLabel.topAnchor.constraint(equalTo: genderSegmentedControl.bottomAnchor, constant: 30),
            weightLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            // Height Label - căn chỉnh với Height TextField
            heightLabel.topAnchor.constraint(equalTo: genderSegmentedControl.bottomAnchor, constant: 30),
            heightLabel.leadingAnchor.constraint(equalTo: heightTextField.leadingAnchor),
            
            // Weight TextField
            weightTextField.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 8),
            weightTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            weightTextField.widthAnchor.constraint(equalToConstant: 150),
            weightTextField.heightAnchor.constraint(equalToConstant: 45),
            
            // Height TextField
            heightTextField.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 8),
            heightTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            heightTextField.widthAnchor.constraint(equalToConstant: 150),
            heightTextField.heightAnchor.constraint(equalToConstant: 45),
            
            // Age TextField (hidden)
            ageTextField.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 0),
            ageTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            ageTextField.widthAnchor.constraint(equalToConstant: 0),
            ageTextField.heightAnchor.constraint(equalToConstant: 0),
            
            // Update Button
            updateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            updateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            updateButton.heightAnchor.constraint(equalToConstant: 50),
            updateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            // Content View bottom constraint
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: heightTextField.bottomAnchor, constant: 50)
        ])
    }
    
    private func setupActions() {
        genderSegmentedControl.addTarget(self, action: #selector(genderSegmentChanged), for: .valueChanged)
        updateButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        
        // Add text field observers
        firstNameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        lastNameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        weightTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        heightTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private func setupSampleData() {
        // Load data if available
        if let data = userData {
            firstNameTextField.text = data.firstName
            lastNameTextField.text = data.lastName
            weightTextField.text = data.weight
            heightTextField.text = data.height
            ageTextField.text = data.age
            
            if data.gender == "Male" {
                genderSegmentedControl.selectedSegmentIndex = 0
                selectedGender = "Male"
            } else if data.gender == "Female" {
                genderSegmentedControl.selectedSegmentIndex = 1
                selectedGender = "Female"
            }
        } else {
            // Không pre-fill data cho lần đầu tạo profile mới
            firstNameTextField.text = ""
            lastNameTextField.text = ""
            weightTextField.text = ""
            heightTextField.text = ""
            ageTextField.text = "25" // Age mặc định
            
            // Select male by default
            genderSegmentedControl.selectedSegmentIndex = 0
            selectedGender = "Male"
        }
        
        // Check validation after setting data
        textFieldDidChange()
    }
    
    @objc private func genderSegmentChanged() {
        selectedGender = genderSegmentedControl.selectedSegmentIndex == 0 ? "Male" : "Female"
        textFieldDidChange()
    }
    
    @objc private func textFieldDidChange() {
        // Check if all visible fields are filled
        let isValid = !(firstNameTextField.text?.isEmpty ?? true) &&
                     !(lastNameTextField.text?.isEmpty ?? true) &&
                     !(weightTextField.text?.isEmpty ?? true) &&
                     !(heightTextField.text?.isEmpty ?? true) &&
                     !selectedGender.isEmpty
        
        // Update button state
        updateButton.isEnabled = isValid
        updateButton.backgroundColor = isValid ?
            UIColor(red: 1.0, green: 0.4, blue: 0.4, alpha: 1.0) :
            UIColor.lightGray
    }
    
    @objc private func updateButtonTapped() {
        // Create user data from form
        let userData = UserData(
            firstName: firstNameTextField.text ?? "",
            lastName: lastNameTextField.text ?? "",
            weight: weightTextField.text ?? "",
            height: heightTextField.text ?? "",
            age: ageTextField.text ?? "25",
            gender: selectedGender
        )
        
        // Call the callback to update profile
        onDataUpdated?(userData)
        
        // Navigate back to list screen
        navigationController?.popViewController(animated: true)
    }
}
