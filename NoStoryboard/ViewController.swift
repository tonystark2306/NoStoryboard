






// ProfileViewController.swift
import UIKit

class ProfileViewController: UIViewController {
    
    var onDataUpdated: ((UserData) -> Void)?
    var onProfileDeleted: (() -> Void)?
    
    private var currentUserData: UserData?
    
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
        label.text = "----"
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
        label.text = "---"
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
    
    private let statsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let statsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add", for: .normal)
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
        view.addSubview(statsContainerView)
        view.addSubview(actionButton)
        
        statsContainerView.addSubview(separatorLine)
        statsContainerView.addSubview(statsStackView)
        
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        setupConstraints()
    }
    
    func setupWithUserData(_ userData: UserData) {
        currentUserData = userData
        updateUI()
    }
    
    private func updateUI() {
        if let userData = currentUserData {
            userNameLabel.text = "\(userData.firstName) \(userData.lastName)"
            
            if let weight = Double(userData.weight), let height = Double(userData.height), height > 0 {
                let heightInMeters = height / 100
                let bmi = weight / (heightInMeters * heightInMeters)
                bmiValueLabel.text = String(format: "%.1f", bmi)
            } else {
                bmiValueLabel.text = "---"
            }
            
            actionButton.setTitle("Edit", for: .normal)
        } else {
            userNameLabel.text = "----"
            bmiValueLabel.text = "---"
            actionButton.setTitle("Add", for: .normal)
        }
        
        updateStatsDisplay()
    }
    
    private func updateStatsDisplay() {
        for subview in statsStackView.arrangedSubviews {
            statsStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
        let stats: [(String, String)]
        if let userData = currentUserData {
            stats = [
                ("\(userData.weight) kg", "Weight"),
                ("\(userData.height) cm", "Height"),
                (userData.age, "Age"),
                (userData.gender, "Gender")
            ]
        } else {
            stats = [
                ("-- kg", "Weight"),
                ("-- cm", "Height"),
                ("--", "Age"),
                ("--", "Gender")
            ]
        }
        
        for (index, (value, title)) in stats.enumerated() {
            let statView = createStatView(value: value, title: title, addSeparator: index < stats.count - 1)
            statsStackView.addArrangedSubview(statView)
        }
    }
    
    private func createStatView(value: String, title: String, addSeparator: Bool) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = .white
        
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
        
        if addSeparator {
            let separator = UIView()
            separator.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
            separator.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(separator)
            
            NSLayoutConstraint.activate([
                separator.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                separator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                separator.widthAnchor.constraint(equalToConstant: 1),
                separator.heightAnchor.constraint(equalToConstant: 30)
            ])
        }
        
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            valueLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
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
            
            bmiTitleLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 30),
            bmiTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bmiValueLabel.topAnchor.constraint(equalTo: bmiTitleLabel.bottomAnchor, constant: 5),
            bmiValueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bmiIndicatorView.topAnchor.constraint(equalTo: bmiValueLabel.bottomAnchor, constant: 10),
            bmiIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bmiIndicatorView.widthAnchor.constraint(equalToConstant: 60),
            bmiIndicatorView.heightAnchor.constraint(equalToConstant: 6),
            
            statsContainerView.topAnchor.constraint(equalTo: bmiIndicatorView.bottomAnchor, constant: 40),
            statsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            separatorLine.topAnchor.constraint(equalTo: statsContainerView.topAnchor),
            separatorLine.leadingAnchor.constraint(equalTo: statsContainerView.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: statsContainerView.trailingAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 1),
            
            statsStackView.topAnchor.constraint(equalTo: separatorLine.bottomAnchor),
            statsStackView.leadingAnchor.constraint(equalTo: statsContainerView.leadingAnchor),
            statsStackView.trailingAnchor.constraint(equalTo: statsContainerView.trailingAnchor),
            statsStackView.bottomAnchor.constraint(equalTo: statsContainerView.bottomAnchor),
            
            actionButton.topAnchor.constraint(equalTo: statsContainerView.bottomAnchor, constant: 30),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 50),
            actionButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func deleteButtonTapped() {
        guard currentUserData != nil else { return }
        showDeleteConfirmation()
    }
    
    private func showDeleteConfirmation() {
        let alert = UIAlertController(
            title: "Delete Profile",
            message: "Are you sure you want to delete?",
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            self?.deleteProfile()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        present(alert, animated: true)
    }
    
    private func deleteProfile() {
        onProfileDeleted?()
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func actionButtonTapped() {
        let informationVC = InformationViewController()
        
        if let userData = currentUserData {
            informationVC.userData = userData
            informationVC.onDataUpdated = { [weak self] updatedData in
                self?.updateUserData(updatedData)
            }
        } else {
            informationVC.onDataUpdated = { [weak self] newData in
                self?.setupWithUserData(newData)
                self?.onDataUpdated?(newData)
            }
        }
        
        navigationController?.pushViewController(informationVC, animated: true)
    }
    
    private func updateUserData(_ userData: UserData) {
        currentUserData = userData
        updateUI()
        onDataUpdated?(userData)
    }
}
