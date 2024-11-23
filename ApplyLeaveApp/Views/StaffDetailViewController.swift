//
//  StaffDetailViewController.swift
//  ApplyLeaveApp
//
//  Created by Vandana's MacbookAir on 22/11/24.
//

import Foundation
import UIKit

class StaffDetailViewController: UIViewController {
    
    var staff: Staff!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        self.title = "Staff Details"
        
        // Default Image
        let defaultImageView = UIImageView()
                
        defaultImageView.image = staff.gender == Gender.male.rawValue ? UIImage(named: "male") : UIImage(named: "female")

        defaultImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Labels for Staff Information
        let nameLabel = UILabel()
        nameLabel.text = "\(staff.firstName) \(staff.lastName)"
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let departmentLabel = UILabel()
        departmentLabel.text = "Department: \(staff.department.rawValue)"
        departmentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let phoneLabel = UILabel()
        phoneLabel.text = "Phone: \(staff.phoneNumber)"
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let dobLabel = UILabel()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dobLabel.text = "DOB:" + dateFormatter.string(from: staff.dob)
        dobLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let genderLabel = UILabel()
        genderLabel.text = "Gender: \(staff.gender)"
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Add views to the screen
        self.view.addSubview(defaultImageView)
        self.view.addSubview(nameLabel)
        self.view.addSubview(departmentLabel)
        self.view.addSubview(phoneLabel)
        self.view.addSubview(dobLabel)
        self.view.addSubview(genderLabel)
        
        // Add layout constraints
        NSLayoutConstraint.activate([
            defaultImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            defaultImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            defaultImageView.widthAnchor.constraint(equalToConstant: 100),
            defaultImageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: defaultImageView.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            departmentLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            departmentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            phoneLabel.topAnchor.constraint(equalTo: departmentLabel.bottomAnchor, constant: 10),
            phoneLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            dobLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 10),
            dobLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            genderLabel.topAnchor.constraint(equalTo: dobLabel.bottomAnchor, constant: 10),
            genderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}
