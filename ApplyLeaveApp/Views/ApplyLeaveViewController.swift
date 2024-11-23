//
//  ApplyLeaveViewController.swift
//  ApplyLeaveApp
//
//  Created by Vandana's MacbookAir on 22/11/24.
//

import Foundation
import UIKit

class ApplyLeaveViewController: UIViewController {
    
    var viewModel: ApplyLeaveViewModel!
    
    var staffPicker: UIPickerView!
    var leaveTypePicker: UIPickerView!
    var leaveDatePicker: UIDatePicker!
    var submitButton: UIButton!
    private var selectedIndex: Int = 0 // Default to 0 initially

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ApplyLeaveViewModel(staffList: StaffManager.shared.staffList)
        setupUI()
    }
    
    private func setupUI() {
        self.view.backgroundColor = UIColor.systemBackground
        self.title = "Apply Leave"
        
        // Set up Staff Picker
        staffPicker = UIPickerView()
        staffPicker.translatesAutoresizingMaskIntoConstraints = false
        staffPicker.delegate = self
        staffPicker.dataSource = self
        staffPicker.layer.cornerRadius = 10
        staffPicker.layer.borderWidth = 1
        staffPicker.layer.borderColor = UIColor.systemGray.cgColor
        self.view.addSubview(staffPicker)
        
        // Set up Leave Type Picker
        leaveTypePicker = UIPickerView()
        leaveTypePicker.translatesAutoresizingMaskIntoConstraints = false
        leaveTypePicker.delegate = self
        leaveTypePicker.dataSource = self
        leaveTypePicker.layer.cornerRadius = 10
        leaveTypePicker.layer.borderWidth = 1
        leaveTypePicker.layer.borderColor = UIColor.systemGray.cgColor
        self.view.addSubview(leaveTypePicker)
        
        // Set up Leave Date Picker
        leaveDatePicker = UIDatePicker()
        leaveDatePicker.translatesAutoresizingMaskIntoConstraints = false
        leaveDatePicker.datePickerMode = .date
        self.view.addSubview(leaveDatePicker)
        
        // Set up Submit Button
        submitButton = UIButton(type: .system)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = UIColor.systemBlue
        submitButton.tintColor = .white
        submitButton.layer.cornerRadius = 15
        submitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        submitButton.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
        self.view.addSubview(submitButton)
        
        // Add layout constraints
        NSLayoutConstraint.activate([
            staffPicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            staffPicker.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            staffPicker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            staffPicker.heightAnchor.constraint(equalToConstant: 150),
            
            leaveTypePicker.topAnchor.constraint(equalTo: staffPicker.bottomAnchor, constant: 20),
            leaveTypePicker.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            leaveTypePicker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            leaveTypePicker.heightAnchor.constraint(equalToConstant: 150),
            
            leaveDatePicker.topAnchor.constraint(equalTo: leaveTypePicker.bottomAnchor, constant: 20),
            leaveDatePicker.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            leaveDatePicker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            submitButton.topAnchor.constraint(equalTo: leaveDatePicker.bottomAnchor, constant: 20),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 44),
            submitButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc func didTapSubmit() {
        viewModel.leaveDate = leaveDatePicker.date

        // Validate form inputs
        if viewModel.validateForm() {
            // Apply leave and update the staff's leave count
            if viewModel.applyLeave() {
                
                self.reloadDataForPicker()
                // Navigate back to the previous screen or show success message
                showAlert(message: "Leave applied successfully", error: false)

            } else {
                showAlert(message: "You have already applied leave for the selected date or Insufficient Leave Balance", error: true)
            }
            
        } else {
            showAlert(message: "Please fill in all fields.", error: true)
        }
    }
    
    func reloadDataForPicker(){
        viewModel.staffList = StaffManager.shared.staffList
        leaveTypePicker.reloadAllComponents()
        self.reloadInputViews()
    }
    
    private func showAlert(message: String, error: Bool = false) {
        let alert = UIAlertController(title: error ? "Error" : "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// Add the UIPickerView delegate and data source methods to ApplyLeaveViewController
extension ApplyLeaveViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == staffPicker {
            return viewModel.staffList.count
        } else if pickerView == leaveTypePicker {
            return LeaveType.allCases.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let defaultLeaveData = LeaveType.allCases[row].rawValue
        
        if pickerView == staffPicker {
            return "\(viewModel.staffList[row].firstName) \(viewModel.staffList[row].lastName)"
        } else if pickerView == leaveTypePicker {
            let leaveData = viewModel.staffList[selectedIndex].availableLeaveDays

            if LeaveType.allCases[row] == LeaveType.paid {
                return "\(defaultLeaveData) \(leaveData[.paid] ?? 0) days"
            } else if LeaveType.allCases[row] == LeaveType.medical {
                return "\(defaultLeaveData) \(leaveData[.medical] ?? 0) days"
            } else {
                return "\(defaultLeaveData) \(leaveData[.birthday] ?? 0) days"
            }
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == staffPicker {
            selectedIndex = row
            viewModel.selectedStaff = viewModel.staffList[row]
        } else if pickerView == leaveTypePicker {
            viewModel.leaveType = LeaveType.allCases[row]
        } else if pickerView == leaveDatePicker {
            viewModel.leaveDate = leaveDatePicker.date
        }
        self.reloadDataForPicker()
    }
}
