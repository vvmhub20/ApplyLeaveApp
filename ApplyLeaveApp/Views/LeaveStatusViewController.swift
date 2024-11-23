//
//  LeaveStatusViewController.swift
//  ApplyLeaveApp
//
//  Created by Vandana's MacbookAir on 22/11/24.
//

import Foundation
import UIKit
import FSCalendar

class LeaveStatusViewController: UIViewController {
    
    var viewModel: LeaveStatusViewModel!
    
    private let calendarView = FSCalendar()
    private var staffTableView: UITableView!
    private var staffList: [Staff] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let list = StaffManager.shared.staffList
        
        // Initialize the ViewModel with the sample staff list
        viewModel = LeaveStatusViewModel(staffList: list)
        
        setupUI()
        setupCalendar()
        setupTableView()
        updateStaffDetails(for: Date())
    }
    
    private func setupUI() {
        view.backgroundColor = .white
    }
    
    private func setupCalendar() {
        // Setup the FSCalendar view
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        // Customize calendar appearance
        calendarView.appearance.headerDateFormat = "MMMM yyyy"
        calendarView.appearance.selectionColor = .blue
        calendarView.appearance.todayColor = .red
        calendarView.appearance.titleDefaultColor = .black
        calendarView.appearance.titleTodayColor = .white
        calendarView.appearance.weekdayTextColor = .darkGray
        
        // Add calendar to the view
        view.addSubview(calendarView)
        
        // Setup calendar constraints
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.heightAnchor.constraint(equalToConstant: 300) // Adjust calendar height
        ])
        
    }
    
    private func setupTableView() {
        // Initialize and configure the table view
        staffTableView = UITableView()
        staffTableView.delegate = self
        staffTableView.dataSource = self
        staffTableView.translatesAutoresizingMaskIntoConstraints = false
        staffTableView.register(StaffTableViewCell.self, forCellReuseIdentifier: "StaffTableViewCell")
        staffTableView.tableFooterView = UIView() // Remove extra separators
        
        // Add table view to the view
        view.addSubview(staffTableView)
        
        // Setup table view constraints
        NSLayoutConstraint.activate([
            staffTableView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 20),
            staffTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            staffTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            staffTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    // Update staff details in the table view based on leave status for the selected date
    func updateStaffDetails(for selectedDate: Date) {
        guard StaffManager.shared.staffList.isEmpty == false  else {
            return
        }
        staffList = viewModel.fetchLeaveStatus(for: selectedDate)
        staffTableView.reloadData()
    }
}

extension LeaveStatusViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        // Return the number of events (leaves) on the given date
        return viewModel.getLeaveStatus().count
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // Called when a date is selected
        print("Selected Date: \(date)")
        updateStaffDetails(for: date)
    }
}

// MARK: - UITableView Delegate & DataSource
extension LeaveStatusViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return staffList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StaffTableViewCell", for: indexPath) as? StaffTableViewCell else {
            return UITableViewCell()
        }
        let staff = staffList[indexPath.row]
        cell.configure(with: staff) // Customize as per your leave types
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Adjust height for card-like appearance
    }
}

