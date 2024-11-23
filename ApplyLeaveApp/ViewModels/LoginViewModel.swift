//
//  LoginViewModel.swift
//  ApplyLeaveApp
//
//  Created by Vandana's MacbookAir on 22/11/24.
//

import Foundation

class LoginViewModel {
    var email: String = ""
    var password: String = ""
    var rememberMe: Bool = false

    var emailError: String? {
        Validators.isValidEmail(email) ? nil : "Please Enter Email or Invalid email format."
    }
    
    var passwordError: String? {
        Validators.isValidPassword(password) ? nil : "Password must be at least 8 characters, include 1 uppercase, 1 special character, and 1 number."
    }
    
    func login(completion: (Bool, String?) -> Void) {
        guard emailError == nil else {
            completion(false, emailError)
            return
        }
        guard passwordError == nil else {
            completion(false, passwordError)
            return
        }
        // Mock login success
        completion(true, nil)
    }
}
