//
//  DrawerMenu.swift
//  ApplyLeaveApp
//
//  Created by Vandana's MacbookAir on 22/11/24.
//

import Foundation
import UIKit

protocol DrawerMenuDelegate: AnyObject {
    func drawerMenuItemSelected(screen: Screen)
}

class DrawerMenu: UIView {

    var tableView: UITableView!
    weak var delegate: DrawerMenuDelegate?

    private let items = ["Profile","Leave Status", "Staff List", "Apply Leave", "Logout"]

    private var profileContainer: UIView!
    private var profileImageView: UIImageView!
    private var emailLabel: UILabel!

     var isMenuOpen = false
    private let drawerWidth: CGFloat = 250

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackground()
        setupHeader()
        setupTableView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupBackground()
        setupHeader()
        setupTableView()
    }

    // MARK: - Setup Background
    private func setupBackground() {
        self.backgroundColor = .black // Ensure solid background
    }

    // MARK: - Setup Header
    private func setupHeader() {
        // Profile Container
        profileContainer = UIView()
        profileContainer.translatesAutoresizingMaskIntoConstraints = false
        profileContainer.backgroundColor = .clear // No background, keeps UI clean
        profileContainer.isUserInteractionEnabled = true
        addSubview(profileContainer)

        // Profile Image View
        profileImageView = UIImageView()
        profileImageView.image = UIImage(systemName: "person.circle")
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.tintColor = AppColor.primaryText
        profileImageView.layer.cornerRadius = 35
        profileImageView.clipsToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileContainer.addSubview(profileImageView)

        // Email Label
        emailLabel = UILabel()
        emailLabel.text = "johndoe@example.com" // Placeholder
        emailLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        emailLabel.textColor = AppColor.primaryText
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        profileContainer.addSubview(emailLabel)

        // Constraints for Profile Container
        NSLayoutConstraint.activate([
            profileContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            profileContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            profileContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            profileContainer.heightAnchor.constraint(equalToConstant: 80),

            // Profile Image
            profileImageView.centerYAnchor.constraint(equalTo: profileContainer.centerYAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: profileContainer.leadingAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            profileImageView.heightAnchor.constraint(equalToConstant: 70),

            // Email Label
            emailLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            emailLabel.trailingAnchor.constraint(equalTo: profileContainer.trailingAnchor)
        ])
    }

    // MARK: - Setup TableView
    private func setupTableView() {
        tableView = UITableView()
        tableView.backgroundColor = .white // Ensure tableView matches background
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: profileContainer.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    

    // MARK: - Toggle Menu
    func toggleMenu() {
        if isMenuOpen {
            UIView.animate(withDuration: 0.3, animations: {
                self.frame.origin.x = -self.drawerWidth
            }) { _ in
                self.isMenuOpen = false
            }
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.frame.origin.x = 0
            }) { _ in
                self.isMenuOpen = true
            }
        }
    }
}

extension DrawerMenu: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrawerItemCell") ?? UITableViewCell(style: .default, reuseIdentifier: "DrawerItemCell")
        cell.backgroundColor = AppColor.primaryText // Ensure cells also have a solid background
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedScreen: Screen
        switch indexPath.row {
        case 0:
            selectedScreen = .profile
        case 1:
            selectedScreen = .leaveStatus
        case 2:
            selectedScreen = .staffList
        case 3:
            selectedScreen = .ApplyLeave
        case 4:
            selectedScreen = .Logout
        default:
            return
        }
        delegate?.drawerMenuItemSelected(screen: selectedScreen)
    }
}
