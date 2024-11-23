//
//  LeaveStatusViewModel.swift
//  ApplyLeaveApp
//
//  Created by Vandana's MacbookAir on 23/11/24.
//

import Foundation

class LeaveStatusViewModel {
    private var staffList: [Staff]
    
    init(staffList: [Staff]) {
        self.staffList = staffList
    }
    
    // Fetch unique leave status for a selected date
    func fetchLeaveStatus(for selectedDate: Date) -> [Staff] {
        let selectedDateString = extractDate(from: selectedDate)
        
        var uniqueStaff: [Staff] = []
        var seenStaffIds: Set<Int> = [] // Assuming `Staff` has a unique identifier like `id`
        
        for staff in staffList where staff.leaveDates.contains(where: { extractDate(from: $0) == selectedDateString }) {
            if !seenStaffIds.contains(staff.uniqueID) { // Replace `id` with a unique property of `Staff`
                uniqueStaff.append(staff)
                seenStaffIds.insert(staff.uniqueID)
            }
        }
        
        return uniqueStaff
    }

    
    // Method to get the staff on leave
    func getLeaveStatus() -> [Staff] {
        let list  = self.staffList.filter { staff in
            return staff.leaveDates.isEmpty == false
        }
        print(list)
        return list
    }

    // Function to extract date as a string
    func extractDate(from date: Date) -> Date? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return calendar.date(from: components) // This will return a Date with only the year, month, and day
    }

}
