// InformationViewController.swift
import UIKit

class InformationViewController: UIViewController {
    
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
        textField.borderStyle = .none
        textField.placeholder = "Enter first name"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.backgroundColor = .white
        textField.placeholder = "Enter last name"
        textField.layer.cornerRadius = 8
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Gender"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .gray
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
        textField.borderStyle = .none
        textField.backgroundColor = .white
        textField.placeholder = "kg"
        textField.layer.cornerRadius = 8
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private let heightTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.placeholder = "cm"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private let ageTextField: UITextField = {
        let textField = UITextField()
        textField.text = "25"
        textField.isHidden = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Update", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.layer.cornerRadius = 25
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var selectedGender: String = "Male"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        loadData()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        title = "Information"
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .medium)
        ]
        
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
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: updateButton.topAnchor, constant: -10),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            firstNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            firstNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            lastNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            lastNameLabel.leadingAnchor.constraint(equalTo: lastNameTextField.leadingAnchor),
            
            firstNameTextField.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 8),
            firstNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            firstNameTextField.widthAnchor.constraint(equalToConstant: 150),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 45),
            
            lastNameTextField.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 8),
            lastNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            lastNameTextField.widthAnchor.constraint(equalToConstant: 150),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 45),
            
            genderLabel.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 30),
            genderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            genderSegmentedControl.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 8),
            genderSegmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            genderSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            genderSegmentedControl.heightAnchor.constraint(equalToConstant: 45),
            
            weightLabel.topAnchor.constraint(equalTo: genderSegmentedControl.bottomAnchor, constant: 30),
            weightLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            heightLabel.topAnchor.constraint(equalTo: genderSegmentedControl.bottomAnchor, constant: 30),
            heightLabel.leadingAnchor.constraint(equalTo: heightTextField.leadingAnchor),
            
            weightTextField.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 8),
            weightTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            weightTextField.widthAnchor.constraint(equalToConstant: 150),
            weightTextField.heightAnchor.constraint(equalToConstant: 45),
            
            heightTextField.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 8),
            heightTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            heightTextField.widthAnchor.constraint(equalToConstant: 150),
            heightTextField.heightAnchor.constraint(equalToConstant: 45),
            
            ageTextField.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 0),
            ageTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            ageTextField.widthAnchor.constraint(equalToConstant: 0),
            ageTextField.heightAnchor.constraint(equalToConstant: 0),
            
            updateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            updateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            updateButton.heightAnchor.constraint(equalToConstant: 50),
            updateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: heightTextField.bottomAnchor, constant: 50)
        ])
    }
    
    private func setupActions() {
        genderSegmentedControl.addTarget(self, action: #selector(genderSegmentChanged), for: .valueChanged)
        updateButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        
        firstNameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        lastNameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        weightTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        heightTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private func loadData() {
        if let data = userData {
            firstNameTextField.text = data.firstName
            lastNameTextField.text = data.lastName
            weightTextField.text = data.weight
            heightTextField.text = data.height
            ageTextField.text = data.age
            
            if data.gender == "Female" {
                genderSegmentedControl.selectedSegmentIndex = 1
                selectedGender = "Female"
            } else {
                genderSegmentedControl.selectedSegmentIndex = 0
                selectedGender = "Male"
            }
        } else {
            firstNameTextField.text = ""
            lastNameTextField.text = ""
            weightTextField.text = ""
            heightTextField.text = ""
            ageTextField.text = "25"
            
            genderSegmentedControl.selectedSegmentIndex = 0
            selectedGender = "Male"
        }
        
        textFieldDidChange()
    }
    
    @objc private func genderSegmentChanged() {
        selectedGender = genderSegmentedControl.selectedSegmentIndex == 0 ? "Male" : "Female"
        textFieldDidChange()
    }
    
    @objc private func textFieldDidChange() {
        let isValid = !(firstNameTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) &&
                     !(lastNameTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) &&
                     !(weightTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) &&
                     !(heightTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) &&
                     !selectedGender.isEmpty
        
        updateButton.isEnabled = isValid
        updateButton.backgroundColor = isValid ?
            UIColor(red: 1.0, green: 0.4, blue: 0.4, alpha: 1.0) :
            UIColor.lightGray
    }
    
    @objc private func updateButtonTapped() {
        let resultData: UserData
        
        if let existingData = userData {
            resultData = UserData(
                id: existingData.id,
                firstName: firstNameTextField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                lastName: lastNameTextField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                weight: weightTextField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                height: heightTextField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                age: ageTextField.text?.trimmingCharacters(in: .whitespaces) ?? "25",
                gender: selectedGender
            )
        } else {
            resultData = UserData(
                firstName: firstNameTextField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                lastName: lastNameTextField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                weight: weightTextField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                height: heightTextField.text?.trimmingCharacters(in: .whitespaces) ?? "",
                age: ageTextField.text?.trimmingCharacters(in: .whitespaces) ?? "25",
                gender: selectedGender
            )
        }
        
        onDataUpdated?(resultData)
        navigationController?.popViewController(animated: true)
    }
}
