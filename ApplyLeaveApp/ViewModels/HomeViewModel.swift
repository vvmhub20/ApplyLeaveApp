//
//  HomeViewModel.swift
//  ApplyLeaveApp
//
//  Created by Vandana's MacbookAir on 22/11/24.
//

import UIKit
import Foundation

enum Screen {
    case leaveStatus
    case staffList
    case ApplyLeave
    case Logout
    case profile

    var viewController: UIViewController {
        switch self {
        case .profile:
            return ProfileViewController()
        case .leaveStatus:
            return LeaveStatusViewController()
        case .staffList:
            return StaffListViewController()
        case .ApplyLeave:
            return ApplyLeaveViewController()
        case .Logout:
            return ProfileViewController()
        }
    }
}


class HomeViewModel {

    var coordinator: HomeCoordinator

    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }

    func loadDefaultScreen() {
        coordinator.navigateTo(screen: .leaveStatus)
    }

    func selectScreen(_ screen: Screen) {
        coordinator.navigateTo(screen: screen)
    }
    
    func logout() {
        // Clear any stored data (like removing from UserDefaults, database, etc.)
        StaffManager.shared.clearUserData()
    }
}
