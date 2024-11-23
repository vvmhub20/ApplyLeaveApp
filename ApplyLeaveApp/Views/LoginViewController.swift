//
//  LoginViewController.swift
//  ApplyLeaveApp
//
//  Created by Vandana's MacbookAir on 22/11/24.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    // MARK: - UI Components
    
    private let mainbackgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill  // To ensure the image fills the screen and retains its aspect ratio
        imageView.image = UIImage(named: "background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        // Set placeholder color
        let placeholderColor = UIColor.lightGray
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter your email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .next
        textField.backgroundColor = .clear
        textField.textColor = AppColor.primaryText
        
        textField.font = UIFont.boldSystemFont(ofSize: 17)
        
        
        return textField
    }()
    
    let emailBackgroundView: UIView = {
        let view = UIView()
        view.layer.borderColor = AppColor.borderColour.cgColor
        view.layer.borderWidth = 1.0
        view.backgroundColor = .clear
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    let passWordBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.layer.borderColor = AppColor.borderColour.cgColor
        view.layer.borderWidth = 1.0
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        let placeholderColor = UIColor.lightGray
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter your Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.textColor = AppColor.primaryText
        textField.isSecureTextEntry = true
        textField.returnKeyType = .done
        textField.backgroundColor = .clear
        
        textField.font = UIFont.boldSystemFont(ofSize: 17)
        
        // Add "Show Password" toggle button
        let showPasswordButton = UIButton(type: .custom)
        showPasswordButton.tintColor = AppColor.borderColour
        showPasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
        showPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        showPasswordButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        textField.rightView = showPasswordButton
        textField.rightViewMode = .always
        
        return textField
    }()
    
    private let rememberMeSwitch: UISwitch = {
        let toggleSwitch = UISwitch()
        toggleSwitch.isOn = false
        toggleSwitch.onTintColor = .gray
        return toggleSwitch
    }()
    
    private let rememberMeLabel: UILabel = {
        let label = UILabel()
        label.text = "Remember Me"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .lightGray
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(AppColor.primaryText, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 25
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return button
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    // MARK: - Properties
    private let viewModel = LoginViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        // Add subviews
        view.addSubview(mainbackgroundView)
        view.addSubview(emailBackgroundView)
        view.addSubview(emailTextField)
        view.addSubview(passWordBackgroundView)
        view.addSubview(passwordTextField)
        view.addSubview(rememberMeSwitch)
        view.addSubview(rememberMeLabel)
        view.addSubview(loginButton)
        view.addSubview(errorLabel)
    }
    
    private func setupConstraints() {
        mainbackgroundView.translatesAutoresizingMaskIntoConstraints = false
        emailBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        passWordBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        rememberMeSwitch.translatesAutoresizingMaskIntoConstraints = false
        rememberMeLabel.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            mainbackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            mainbackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainbackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainbackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            emailBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailBackgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -120),
            emailBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            emailBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            emailBackgroundView.heightAnchor.constraint(equalToConstant: 50),
            
            // Email TextField
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -120),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            
            // Password TextField
            passWordBackgroundView.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor),
            passWordBackgroundView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passWordBackgroundView.leadingAnchor.constraint(equalTo: emailBackgroundView.leadingAnchor),
            passWordBackgroundView.trailingAnchor.constraint(equalTo: emailBackgroundView.trailingAnchor),
            passWordBackgroundView.heightAnchor.constraint(equalToConstant: 50),
            
            
            // Password TextField
            passwordTextField.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Remember Me
            rememberMeSwitch.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            rememberMeSwitch.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            
            rememberMeLabel.centerYAnchor.constraint(equalTo: rememberMeSwitch.centerYAnchor),
            rememberMeLabel.leadingAnchor.constraint(equalTo: rememberMeSwitch.trailingAnchor, constant: 10),
            
            // Login Button
            loginButton.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: rememberMeSwitch.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Error Label
            errorLabel.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor),
            errorLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            errorLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
        ])
    }
    
    
    // MARK: - Actions
    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected.toggle()
        passwordTextField.isSecureTextEntry = !sender.isSelected
    }
    
    @objc private func loginTapped() {
        viewModel.email = emailTextField.text ?? ""
        viewModel.password = passwordTextField.text ?? ""
        viewModel.rememberMe = rememberMeSwitch.isOn
        
        let user = User(username: viewModel.email, email: viewModel.password, rememberMe:  viewModel.rememberMe)
        StaffManager.shared.user = user
        
        
        viewModel.login { [weak self] success, error in
            guard let self = self else { return }
            
            if success {
                self.errorLabel.isHidden = true
                self.navigateToHome()
            } else {
                self.errorLabel.text = error
                self.errorLabel.isHidden = false
            }
        }
    }
    
    private func navigateToHome() {
        // Navigate to the home screen
        let homeViewController = HomeViewController()
        let coordinator = HomeCoordinator(homeViewController: homeViewController)
        let viewModel = HomeViewModel(coordinator: coordinator)
        homeViewController.viewModel = viewModel
        
        
        // Wrap it in a navigation controller (if needed)
        let navigationController = UINavigationController(rootViewController: homeViewController)
        
        // Access the SceneDelegate to change the root view controller
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            // Set HomeViewController as the root view controller
            sceneDelegate.window?.rootViewController = navigationController
            sceneDelegate.window?.makeKeyAndVisible()
        }
        
    }
}
