//
//  StaffListViewController.swift
//  ApplyLeaveApp
//
//  Created by Vandana's MacbookAir on 22/11/24.
//

import Foundation
import UIKit

class StaffListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var viewModel = StaffListViewModel()
    var tableView: UITableView!
    var noDataLabel: UILabel! // Label to show when no staff is available
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the current staff list from the shared manager
        viewModel.staffList = StaffManager.shared.staffList
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Refresh the list when we return from AddStaffViewController
        viewModel.staffList = StaffManager.shared.staffList
        tableView.reloadData()
        updateNoDataLabelVisibility() // Check if no data exists
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        self.title = "Staff List"
        
        // Set up TableView
        tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(StaffTableViewCell.self, forCellReuseIdentifier: "StaffTableViewCell")
        self.view.addSubview(tableView)
        
        // Set up No Data Available Label
        noDataLabel = UILabel()
        noDataLabel.translatesAutoresizingMaskIntoConstraints = false
        noDataLabel.text = "No Data Available"
        noDataLabel.textAlignment = .center
        noDataLabel.font = UIFont.systemFont(ofSize: 18)
        noDataLabel.textColor = UIColor.gray
        noDataLabel.isHidden = true // Initially hidden
        self.view.addSubview(noDataLabel)
        
        // Constraints for TableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Constraints for No Data Label
        NSLayoutConstraint.activate([
            noDataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noDataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Set up FAB button
        let fabButton = UIButton()
        fabButton.translatesAutoresizingMaskIntoConstraints = false
        fabButton.backgroundColor = AppColor.background
        fabButton.layer.cornerRadius = 30
        fabButton.setTitle("+", for: .normal)
        fabButton.addTarget(self, action: #selector(didTapFAB), for: .touchUpInside)
        self.view.addSubview(fabButton)
        
        NSLayoutConstraint.activate([
            fabButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            fabButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30),
            fabButton.widthAnchor.constraint(equalToConstant: 60),
            fabButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func didTapFAB() {
        let addStaffVC = AddStaffViewController()
        self.navigationController?.pushViewController(addStaffVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let staff = viewModel.staffAt(index: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "StaffTableViewCell", for: indexPath) as? StaffTableViewCell
        cell?.configure(with: staff)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedStaff = viewModel.staffList[indexPath.row]
        
        let staffDetailVC = StaffDetailViewController()
        staffDetailVC.staff = selectedStaff
        
        navigationController?.pushViewController(staffDetailVC, animated: true)
    }
    
    // Helper method to update the visibility of the "No Data Available" label
    private func updateNoDataLabelVisibility() {
        if viewModel.staffList.isEmpty {
            noDataLabel.isHidden = false
        } else {
            noDataLabel.isHidden = true
        }
    }
}
