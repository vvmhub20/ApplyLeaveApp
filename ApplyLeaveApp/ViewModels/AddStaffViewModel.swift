//
//  AddStaffViewModel.swift
//  ApplyLeaveApp
//
//  Created by Vandana's MacbookAir on 22/11/24.
//

import Foundation

class AddStaffViewModel {
    var firstName: String?
    var lastName: String?
    var department: Department?
    var phoneNumber: String?
    var dob: Date?
    var gender: String?
    
    func validateFields() -> Bool {
        guard let firstName = firstName, !firstName.isEmpty,
              let lastName = lastName, !lastName.isEmpty,
              let department = department,
              let phoneNumber = phoneNumber, !phoneNumber.isEmpty,
              let dob = dob,
              let gender = gender else {
                  return false
              }
        return true
    }
    
    func createStaff() -> Staff? {
        guard validateFields() else { return nil }
        return Staff(firstName: firstName!, lastName: lastName!, department: department!, phoneNumber: phoneNumber!, dob: dob!, gender: gender!)
    }
}
    