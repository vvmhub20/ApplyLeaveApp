//
//  StaffListViewModel.swift
//  ApplyLeaveApp
//
//  Created by Vandana's MacbookAir on 22/11/24.
//

import Foundation

class StaffListViewModel {
    var staffList: [Staff] = []
    
    func addStaff(_ staff: Staff) {
        staffList.append(staff)
    }
    
    func numberOfRows() -> Int {
        return staffList.count
    }
    
    func staffAt(index: Int) -> Staff {
        return staffList[index]
    }
}
