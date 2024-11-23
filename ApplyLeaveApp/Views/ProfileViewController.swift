//
//  ProfileViewController.swift
//  ApplyLeaveApp
//
//  Created by Vandana's MacbookAir on 22/11/24.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel = ProfileViewModel()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private let rememberMeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.isHidden = true
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel.fetchUserProfile()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        rememberMeLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(profileImageView)
        view.addSubview(usernameLabel)
        view.addSubview(emailLabel)
        view.addSubview(rememberMeLabel)
        view.addSubview(errorLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            usernameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 20),
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            rememberMeLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            rememberMeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
 
            
            errorLabel.topAnchor.constraint(equalTo: rememberMeLabel.bottomAnchor, constant: 20),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: - Bindings
    private func setupBindings() {
        viewModel.onDataFetched = { [weak self] in
            self?.updateUI()
        }
        
        viewModel.onError = { [weak self] errorMessage in
            self?.showError(message: errorMessage)
        }
    }
    
    // MARK: - UI Update
    private func updateUI() {
        
        guard viewModel.user != nil else { return }
        
        let email = "\(viewModel.getUsername())"
        
        let username = extractUsername(from: email)
        print(username)
        
        usernameLabel.text = "Username: \(username)"
        emailLabel.text = "Email: \(viewModel.getEmail())"
        rememberMeLabel.text = "Remember Me: \(viewModel.getRememberMeStatus())"
        
        // Assuming a default profile image
        profileImageView.image = UIImage(systemName: "person.circle")

    }
    
    // MARK: - Error Handling
    private func showError(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    func extractUsername(from email: String) -> String {
        guard let atIndex = email.firstIndex(of: "@") else {
            return email // Return the full email if "@" is not found
        }
        return String(email[..<atIndex])
    }

}
