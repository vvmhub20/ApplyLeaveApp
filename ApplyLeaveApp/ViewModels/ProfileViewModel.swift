//
//  ProfileViewModel.swift
//  ApplyLeaveApp
//
//  Created by Vandana's MacbookAir on 22/11/24.
//

import Foundation

class ProfileViewModel {
    
    var user: User?
    
    var onDataFetched: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func fetchUserProfile() {
        // Simulate fetching user data
        // Normally, this would be fetched from a database or a network request
        let user = StaffManager.shared.user
        let userProfile = User(username: user?.username ?? "" , email: user?.email ?? "", rememberMe: user?.rememberMe ?? false)
        self.user = userProfile
        onDataFetched?()
    }
    
  
    
    func getUsername() -> String {
        return user?.username ?? "Unknown"
    }
    
    func getEmail() -> String {
        return user?.email ?? "Not available"
    }
    
    func getRememberMeStatus() -> String {
        guard let rememberMe = user?.rememberMe else { return "Not available" }
        return rememberMe ? "Yes" : "No"
    }
}
