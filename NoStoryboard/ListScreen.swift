// ListScreen.swift
import UIKit

class ListScreen: UIViewController {
    
    private var profiles: [UserData] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let emptyStateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let emptyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "gift_box") ?? UIImage(systemName: "gift")
        imageView.tintColor = UIColor(red: 0.6, green: 0.6, blue: 0.7, alpha: 1.0)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let emptyTitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emptyMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "Empty folder, please tap \"Add Profile\"\n button to create new profile"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Profile", for: .normal)
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
        setupTableView()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        title = "List"
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .medium)
        ]
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addProfileButtonTapped)
        )
        addButton.tintColor = UIColor(red: 1.0, green: 0.4, blue: 0.4, alpha: 1.0)
        navigationItem.rightBarButtonItem = addButton
        
        view.addSubview(tableView)
        view.addSubview(emptyStateView)
        
        emptyStateView.addSubview(emptyImageView)
        emptyStateView.addSubview(emptyTitleLabel)
        emptyStateView.addSubview(emptyMessageLabel)
        emptyStateView.addSubview(addProfileButton)
        
        addProfileButton.addTarget(self, action: #selector(addProfileButtonTapped), for: .touchUpInside)
        
        setupConstraints()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileCell")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyStateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyImageView.centerXAnchor.constraint(equalTo: emptyStateView.centerXAnchor),
            emptyImageView.centerYAnchor.constraint(equalTo: emptyStateView.centerYAnchor, constant: -80),
            emptyImageView.widthAnchor.constraint(equalToConstant: 100),
            emptyImageView.heightAnchor.constraint(equalToConstant: 100),
            
            emptyTitleLabel.topAnchor.constraint(equalTo: emptyImageView.bottomAnchor, constant: 20),
            emptyTitleLabel.centerXAnchor.constraint(equalTo: emptyStateView.centerXAnchor),
            
            emptyMessageLabel.topAnchor.constraint(equalTo: emptyTitleLabel.bottomAnchor, constant: 10),
            emptyMessageLabel.centerXAnchor.constraint(equalTo: emptyStateView.centerXAnchor),
            emptyMessageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: emptyStateView.leadingAnchor, constant: 40),
            emptyMessageLabel.trailingAnchor.constraint(lessThanOrEqualTo: emptyStateView.trailingAnchor, constant: -40),
            
            addProfileButton.topAnchor.constraint(equalTo: emptyMessageLabel.bottomAnchor, constant: 30),
            addProfileButton.centerXAnchor.constraint(equalTo: emptyStateView.centerXAnchor),
            addProfileButton.widthAnchor.constraint(equalToConstant: 150),
            addProfileButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func updateUI() {
        let isEmpty = profiles.isEmpty
        emptyStateView.isHidden = !isEmpty
        tableView.isHidden = isEmpty
        
        if !isEmpty {
            tableView.reloadData()
        }
    }
    
    @objc private func addProfileButtonTapped() {
        let informationVC = InformationViewController()
        informationVC.onDataUpdated = { [weak self] userData in
            self?.addNewProfile(userData)
        }
        navigationController?.pushViewController(informationVC, animated: true)
    }
    
    private func addNewProfile(_ userData: UserData) {
        profiles.append(userData)
        navigationController?.popToViewController(self, animated: true)
        updateUI()
    }
    
    private func navigateToProfile(with userData: UserData) {
        let profileVC = ProfileViewController()
        profileVC.setupWithUserData(userData)
        profileVC.onDataUpdated = { [weak self] updatedData in
            self?.updateProfile(updatedData)
        }
        profileVC.onProfileDeleted = { [weak self] in
            self?.deleteProfile(userData.id)
        }
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    private func updateProfile(_ updatedData: UserData) {
        if let index = profiles.firstIndex(where: { $0.id == updatedData.id }) {
            profiles[index] = updatedData
            updateUI()
        }
    }
    
    private func deleteProfile(_ profileId: UUID) {
        profiles.removeAll { $0.id == profileId }
        updateUI()
    }
}

extension ListScreen: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileTableViewCell
        cell.configure(with: profiles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigateToProfile(with: profiles[indexPath.row])
    }
}
