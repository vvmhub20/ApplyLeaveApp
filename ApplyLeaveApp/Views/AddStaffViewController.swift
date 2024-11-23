//
//  AddStaffViewController.swift
//  ApplyLeaveApp
//
//  Created by Vandana's MacbookAir on 22/11/24.
//

import Foundation
import UIKit

enum Gender: String, CaseIterable {
    case male = "Male"
    case female = "Female"
}

class AddStaffViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var viewModel = AddStaffViewModel()
    var firstNameTextField: UITextField!
    var lastNameTextField: UITextField!
    var departmentPicker: UIPickerView!
    var phoneNumberTextField: UITextField!
    var dobPicker: UIDatePicker!
    var genderPicker: UISegmentedControl!
    var submitButton: UIButton!
    
    // Model data for departments
    let departments = ["IT", "Sales", "Management"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.view.backgroundColor = UIColor.systemBackground
        self.title = "Add Staff"
        
        // Set up First Name TextField
        firstNameTextField = createTextField(placeholder: "First Name")
        self.view.addSubview(firstNameTextField)
        
        // Set up Last Name TextField
        lastNameTextField = createTextField(placeholder: "Last Name")
        self.view.addSubview(lastNameTextField)
        
        // Set up Phone Number TextField
        phoneNumberTextField = createTextField(placeholder: "Phone Number")
        phoneNumberTextField.keyboardType = .numberPad
        self.view.addSubview(phoneNumberTextField)
        
        // Set up Department Picker
        departmentPicker = UIPickerView()
        departmentPicker.translatesAutoresizingMaskIntoConstraints = false
        departmentPicker.delegate = self
        departmentPicker.dataSource = self
        self.view.addSubview(departmentPicker)
        
        // Set up Date of Birth Picker
        dobPicker = UIDatePicker()
        dobPicker.translatesAutoresizingMaskIntoConstraints = false
        dobPicker.datePickerMode = .date // Show only date (no time)
        dobPicker.preferredDatePickerStyle = .wheels // Modern wheels style
        self.view.addSubview(dobPicker)
        
        // Set up Gender Picker
        genderPicker = UISegmentedControl(items: ["Male", "Female"])
        genderPicker.selectedSegmentIndex = 0 // Default to "Male"
        genderPicker.tintColor = UIColor.systemBlue
        genderPicker.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(genderPicker)
        
        // Set up Submit Button
        submitButton = UIButton(type: .system)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = UIColor.systemBlue
        submitButton.tintColor = .white
        submitButton.layer.cornerRadius = 10
        submitButton.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
        self.view.addSubview(submitButton)
        
        // Add layout constraints
        NSLayoutConstraint.activate([
            firstNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            firstNameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            firstNameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 10),
            lastNameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            lastNameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            phoneNumberTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 10),
            phoneNumberTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            phoneNumberTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 40),
            
            departmentPicker.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 20),
            departmentPicker.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            departmentPicker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            departmentPicker.heightAnchor.constraint(equalToConstant: 100),
            
            dobPicker.topAnchor.constraint(equalTo: departmentPicker.bottomAnchor, constant: 20),
            dobPicker.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            dobPicker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            dobPicker.heightAnchor.constraint(equalToConstant: 100),
            
            genderPicker.topAnchor.constraint(equalTo: dobPicker.bottomAnchor, constant: 20),
            genderPicker.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            genderPicker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            submitButton.topAnchor.constraint(equalTo: genderPicker.bottomAnchor, constant: 20),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: 250),
            submitButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        viewModel.department = Department.IT
    }
    
    // MARK: - UIPickerView DataSource & Delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return departments.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return departments[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Convert string to Department enum
        if let department = Department(rawValue: departments[row]) {
            viewModel.department = department // Set the department in the view model
        }
    }
    
    @objc func didTapSubmit() {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty else {
            showAlert(message: "Please enter first name")
            return
        }
        guard let lastName = lastNameTextField.text, !lastName.isEmpty else {
            showAlert(message: "Please enter last name")
            return
        }
        guard let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty else {
            showAlert(message: "Please enter phone number")
            return
        }
        
        // Validate phone number
        if !validatePhoneNumber(phoneNumberTextField.text) {
            showAlert(message: "Please enter a valid phone number.")
            return
        }
        
        
        viewModel.firstName = firstName
        viewModel.lastName = lastName
        viewModel.phoneNumber = phoneNumber
        viewModel.dob = dobPicker.date
        viewModel.gender = genderPicker.titleForSegment(at: genderPicker.selectedSegmentIndex)
        
        if let staff = viewModel.createStaff() {
            // Add the staff to the shared manager
            StaffManager.shared.addStaff(staff)
            navigationController?.popViewController(animated: true)
        } else {
            showAlert(message: "Failed to create staff")
        }
    }
    
    
    
    // Phone number validation
    private func validatePhoneNumber(_ phoneNumber: String?) -> Bool {
        guard let phoneNumber = phoneNumber else { return false }
        
        // Regular expression for Indian phone numbers (10 digits starting with 7, 8, or 9)
        let phoneRegex = "^[789][0-9]{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phoneNumber)
    }
    
    private func createTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
