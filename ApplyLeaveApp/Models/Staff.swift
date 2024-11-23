//
//  Staff.swift
//  ApplyLeaveApp
//
//  Created by Vandana's MacbookAir on 22/11/24.
//

import Foundation

enum Department: String, CaseIterable {
    case IT = "IT"
    case Sales = "Sales"
    case Management = "Management"
}

class Staff {
    static var uniqueIDCounter = 0 // Static counter to generate unique IDs
    
    var firstName: String
    var lastName: String
    var department: Department
    var phoneNumber: String
    var dob: Date
    var gender: String
    var availableLeaveDays: [LeaveType: Int]
    var leaveDates: [Date] // Track leave dates for each leave type
    var uniqueID: Int

    init(firstName: String, lastName: String, department: Department, phoneNumber: String, dob: Date, gender: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.department = department
        self.phoneNumber = phoneNumber
        self.dob = dob
        self.gender = gender
        self.availableLeaveDays = [.medical: 5, .paid: 10, .birthday: 1]
        self.leaveDates = [] // Initialize empty sets for leave dates
        self.uniqueID = Staff.generateUniqueID() // Assign a unique ID

    }
    
    func deductLeaveDays(leaveDays: Int, leaveType:LeaveType, leaveDate: Date) {
        
        if let availableLeave = availableLeaveDays[leaveType], availableLeave >= leaveDays {
            
            availableLeaveDays[leaveType]! -= leaveDays
            
            // Add leave date to leaveDates dictionary
            leaveDates.append(leaveDate)
            
            StaffManager.shared.updateStaff(self)
            
            print(availableLeaveDays[.paid] as Any)
            print(availableLeaveDays[.birthday] as Any)
            print(availableLeaveDays[.medical] as Any)
        }
    }
    
    // Check if a staff member is on leave for a given date
       func isOnLeave(for date: Date, leaveType: LeaveType) -> Bool {
           return leaveDates.contains(date) 
       }
    
    // Generate a unique ID for each staff member
      private static func generateUniqueID() -> Int {
          uniqueIDCounter += 1
          return uniqueIDCounter
      }
}


