//
//  ApplyLeaveViewModel.swift
//  ApplyLeaveApp
//
//  Created by Vandana's MacbookAir on 22/11/24.
//

import Foundation

class ApplyLeaveViewModel {
    
    var staffList: [Staff]
    var selectedStaff: Staff?
    var leaveType: LeaveType?
    var leaveDate: Date?
    
    init(staffList: [Staff]) {
        self.staffList = staffList
    }
    
    // Validate the form before submitting the leave request
    func validateForm() -> Bool {
        
        // Check if a staff member is selected. If not, set a default staff (e.g., first staff in the list)
          if  selectedStaff == nil, !StaffManager.shared.staffList.isEmpty {
              selectedStaff = StaffManager.shared.staffList[0] // Set default to the first staff
          }
          
          // Check if a leave type is selected. If not, set a default leave type (e.g., Medical Leave)
          if leaveType == nil {
              leaveType = LeaveType.medical // Default leave type
          }
        
        return selectedStaff != nil && leaveType != nil && leaveDate != nil
    }
    
    // Apply leave and update the staff's leave balance
    func applyLeave() -> Bool {
        guard let staff = selectedStaff, let leaveType = leaveType, let leaveDate = leaveDate else { return false }
        
        // Extract the date in a comparable format
        let leaveDateString = extractDate(from: leaveDate)
        
        // Check if a leave for the same date is already applied
        let isLeaveAlreadyApplied = staff.leaveDates.contains { existingLeaveDate in
            extractDate(from: existingLeaveDate) == leaveDateString
        }
        
        if isLeaveAlreadyApplied {
            return false
        }
        
        // Check if the staff has enough leave days
        if let availableLeaveDays = staff.availableLeaveDays[leaveType], availableLeaveDays > 0 {
            // Deduct leave days from the selected staff
            staff.deductLeaveDays(leaveDays: 1, leaveType: leaveType, leaveDate: leaveDate)
            return true
        } else {
            // Show an alert if no leave days are available
        }
        
        return false
    }

    
    // Function to extract date as a string
    func extractDate(from date: Date) -> Date? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return calendar.date(from: components) // This will return a Date with only the year, month, and day
    }

}
