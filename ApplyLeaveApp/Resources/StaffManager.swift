//
//  StaffManager.swift
//  ApplyLeaveApp
//
//  Created by Vandana's MacbookAir on 22/11/24.
//

import Foundation

class StaffManager {
    static let shared = StaffManager()
    
    var staffList: [Staff] = []
    var user: User?
    
    private init() {}
    
    func addStaff(_ staff: Staff) {
        staffList.append(staff)
    }
    
    // Update the staff information in the list
      func updateStaff(_ updatedStaff: Staff) {
          if let index = staffList.firstIndex(where: { $0.firstName == updatedStaff.firstName && $0.lastName == updatedStaff.lastName }) {
              staffList[index] = updatedStaff
          }
      }
      
      // Find staff by name
      func getStaff(byName firstName: String, lastName: String) -> Staff? {
          return staffList.first { $0.firstName == firstName && $0.lastName == lastName }
      }
    
    
    // Method to clear data (logout)
        func clearUserData() {
            self.staffList = []
            self.user = nil
        }
    
}
