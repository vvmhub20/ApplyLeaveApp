//
//  StaffTableViewCell.swift
//  ApplyLeaveApp
//
//  Created by Vandana's MacbookAir on 23/11/24.
//

import Foundation
import UIKit

class StaffTableViewCell: UITableViewCell {
    
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#F4F6F9")
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    // Profile picture
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "person.circle.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 40 // Half of width/height for circular shape
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // Labels for details
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    
    private let dobLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(hex: "#77828D")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contactLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#77828D")
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: "#77828D")
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add subviews
        contentView.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(dobLabel)
        contentView.addSubview(contactLabel)
        contentView.addSubview(genderLabel)
        
        // Set up constraints
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        // Set up constraints for cardView
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        // Profile Image Constraints
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        profileImageView.layer.cornerRadius = 40
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.borderColor = UIColor.gray.cgColor
        profileImageView.layer.borderWidth = 1
        
        // Name Label Constraints
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)
        ])
        
        
        // Date of Birth Label Constraints
        NSLayoutConstraint.activate([
            dobLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            dobLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8)
        ])
        
        // Contact Label Constraints
        NSLayoutConstraint.activate([
            contactLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            contactLabel.topAnchor.constraint(equalTo: dobLabel.bottomAnchor, constant: 8)
        ])
        
        // Gender Label Constraints
        NSLayoutConstraint.activate([
            genderLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            genderLabel.topAnchor.constraint(equalTo: contactLabel.bottomAnchor, constant: 8),
            genderLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    // Configure cell with data
    func configure(with profile: Staff) {
        profileImageView.image = profile.gender == Gender.male.rawValue ? UIImage(named: "male") : UIImage(named: "female")
        dateChanged(date: profile.dob)
        nameLabel.text = (profile.firstName) + " " + (profile.lastName )
        contactLabel.text = "Contact: \(profile.phoneNumber )"
        genderLabel.text = "Gender: \(profile.gender)"
    }
    
    
    func dateChanged(date:Date) {
        // Format the selected date to MM/dd/yyyy
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dobLabel.text = "DOB: " + dateFormatter.string(from: date)
        
    }
    
}
