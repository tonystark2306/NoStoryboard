// ProfileViewController.swift
import UIKit

class ProfileViewController: UIViewController {
    
    var onDataUpdated: ((UserData) -> Void)?
    var onProfileDeleted: (() -> Void)?
    
    private var currentUserData: UserData?
    private var userName: String = ""
    private var userWeight: String = ""
    private var userHeight: String = ""
    private var userAge: String = ""
    private var userGender: String = ""
    
    private let profileImageView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1.0, green: 0.4, blue: 0.4, alpha: 1.0)
        view.layer.cornerRadius = 40
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
  
    
    private let userIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bmiTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your BMI:"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bmiValueLabel: UILabel = {
        let label = UILabel()
        label.text = "0.0"
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bmiIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0)
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let statsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 1.0, green: 0.4, blue: 0.4, alpha: 1.0)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        title = "Profile"
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .medium)
        ]
        
        // Add delete button to navigation bar
        let deleteButton = UIBarButtonItem(
            image: UIImage(systemName: "trash"),
            style: .plain,
            target: self,
            action: #selector(deleteButtonTapped)
        )
        deleteButton.tintColor = UIColor.systemRed
        navigationItem.rightBarButtonItem = deleteButton
        
        view.addSubview(profileImageView)
        profileImageView.addSubview(userIconImageView)
        view.addSubview(userNameLabel)
        view.addSubview(bmiTitleLabel)
        view.addSubview(bmiValueLabel)
        view.addSubview(bmiIndicatorView)
        view.addSubview(statsStackView)
        view.addSubview(editButton)
        
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        setupConstraints()
    }
    
    func setupWithUserData(_ userData: UserData) {
        currentUserData = userData
        userName = "\(userData.firstName) \(userData.lastName)"
        userWeight = userData.weight
        userHeight = userData.height
        userAge = userData.age
        userGender = userData.gender
        
        updateUI()
    }
    
    private func updateUI() {
        userNameLabel.text = userName
        
        if let weight = Double(userWeight), let height = Double(userHeight), height > 0 {
            let heightInMeters = height / 100
            let bmi = weight / (heightInMeters * heightInMeters)
            bmiValueLabel.text = String(format: "%.1f", bmi)
        }
        
        updateStatsDisplay()
    }
    
    private func updateStatsDisplay() {
        for subview in statsStackView.arrangedSubviews {
            statsStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
        let stats = [
            (userWeight.isEmpty ? "-- kg" : "\(userWeight) kg", "Weight"),
            (userHeight.isEmpty ? "-- cm" : "\(userHeight) cm", "Height"),
            (userAge.isEmpty ? "--" : userAge, "Age"),
            (userGender.isEmpty ? "--" : userGender, "Gender")
        ]
        
        for (value, title) in stats {
            let statView = createStatView(value: value, title: title)
            statsStackView.addArrangedSubview(statView)
        }
    }
    
    private func createStatView(value: String, title: String) -> UIView {
        let containerView = UIView()
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        valueLabel.textColor = .black
        valueLabel.textAlignment = .center
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        titleLabel.textColor = .gray
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(valueLabel)
        containerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            valueLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        return containerView
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            
            userIconImageView.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            userIconImageView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            userIconImageView.widthAnchor.constraint(equalToConstant: 40),
            userIconImageView.heightAnchor.constraint(equalToConstant: 40),
            
            userNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            userNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bmiTitleLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 20),
            bmiTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bmiValueLabel.topAnchor.constraint(equalTo: bmiTitleLabel.bottomAnchor, constant: 5),
            bmiValueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bmiIndicatorView.topAnchor.constraint(equalTo: bmiValueLabel.bottomAnchor, constant: 10),
            bmiIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bmiIndicatorView.widthAnchor.constraint(equalToConstant: 60),
            bmiIndicatorView.heightAnchor.constraint(equalToConstant: 6),
            
            statsStackView.topAnchor.constraint(equalTo: bmiIndicatorView.bottomAnchor, constant: 40),
            statsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            statsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            editButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            editButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            editButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func deleteButtonTapped() {
        showDeleteConfirmation()
    }
    
    private func showDeleteConfirmation() {
        let alert = UIAlertController(
            title: "Delete Profile",
            message: "Are you sure you want to delete?",
            preferredStyle: .alert
        )
        
        // Customize alert appearance
        alert.setValue(NSAttributedString(
            string: "Delete Profile",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold),
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
        ), forKey: "attributedTitle")
        
        alert.setValue(NSAttributedString(
            string: "Are you sure you want to delete?",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
                NSAttributedString.Key.foregroundColor: UIColor.gray
            ]
        ), forKey: "attributedMessage")
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            // Do nothing
        }
        
        let deleteAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            self?.deleteProfile()
        }
        
        // Customize button colors
        cancelAction.setValue(UIColor.black, forKey: "titleTextColor")
        deleteAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        // Custom alert view styling
        if let alertView = alert.view.subviews.first?.subviews.first?.subviews.first {
            alertView.backgroundColor = UIColor.white
            alertView.layer.cornerRadius = 12
        }
        
        present(alert, animated: true)
    }
    
    private func deleteProfile() {
        // Call the callback to notify ListScreen about deletion
        onProfileDeleted?()
        
        // Navigate back to list screen
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func editButtonTapped() {
        guard let userData = currentUserData else { return }
        
        let informationVC = InformationViewController()
        informationVC.userData = userData
        informationVC.onDataUpdated = { [weak self] updatedData in
            self?.updateUserData(updatedData)
        }
        
        navigationController?.pushViewController(informationVC, animated: true)
    }
    
    private func updateUserData(_ userData: UserData) {
        currentUserData = userData
        userName = "\(userData.firstName) \(userData.lastName)"
        userWeight = userData.weight
        userHeight = userData.height
        userAge = userData.age
        userGender = userData.gender
        
        updateUI()
        onDataUpdated?(userData)
    }
}
