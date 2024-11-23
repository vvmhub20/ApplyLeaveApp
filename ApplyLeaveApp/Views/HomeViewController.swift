//
//  HomeViewController.swift
//  ApplyLeaveApp
//
//  Created by Vandana's MacbookAir on 22/11/24.
//

import Foundation
import UIKit

class HomeViewController: UIViewController, DrawerMenuDelegate {
  
    
    
    var viewModel: HomeViewModel!
    var drawerMenu: DrawerMenu!
    var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupContainerView()
        setupDrawerMenu()
        self.navigationController?.navigationBar.tintColor = AppColor.background
        // Default screen load
        viewModel.loadDefaultScreen()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(openDrawerMenu))
    }
    
    private func setupDrawerMenu() {
        drawerMenu = DrawerMenu(frame: CGRect(x: -250, y: 0, width: 250, height: self.view.frame.height)) // Positioned off-screen initially
        drawerMenu.delegate = self
        self.view.addSubview(drawerMenu)
        
    }
    
    private func setupContainerView() {
        containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(containerView)
    }
    
    @objc func openDrawerMenu() {
        drawerMenu.toggleMenu()
        if drawerMenu.isMenuOpen {
            showLeftBarButton()
        } else {
            hideLeftBarButton()
        }
    }
    
    
    func hideLeftBarButton() {
          self.navigationItem.leftBarButtonItem = nil
      }
      
      func showLeftBarButton() {
          self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(openDrawerMenu))
      }
    
    func displayScreen(_ screen: Screen) {
        if StaffManager.shared.staffList.isEmpty && screen == .ApplyLeave {
            showAlert(message: "Please Add Staff First")
            return
        }
        openDrawerMenu()

        let screenViewController = screen.viewController
        addChild(screenViewController)
        title = "\(screen)"
        containerView.addSubview(screenViewController.view)
        screenViewController.didMove(toParent: self)
    }
    
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title:  "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    
    func drawerMenuItemSelected(screen: Screen) {
        if screen == .Logout {
            logoutButtonTapped()
        }else{
            displayScreen(screen)
        }
    }
    
    @objc private func logoutButtonTapped() {
        // Create an alert controller to ask for permission
        let alertController = UIAlertController(
            title: "Logout",
            message: "Are you sure you want to logout?",
            preferredStyle: .alert
        )
        
        // Add a Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            // Handle cancellation
            print("Logout cancelled")
        }
        
        // Add a Logout action
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { _ in
            // Handle logout
            self.performLogout()
        }
        
        // Add actions to the alertr
        alertController.addAction(cancelAction)
        alertController.addAction(logoutAction)
        
        // Present the alert
        present(alertController, animated: true, completion: nil)
    }
       
       // Function to perform logout
       private func performLogout() {
           viewModel.logout()
           navigateToLogin()
       }
   
    
    
    private func navigateToLogin() {
        // Navigate to the home screen
        let loginVC = LoginViewController()
        
        // Wrap it in a navigation controller (if needed)
        let navigationController = UINavigationController(rootViewController: loginVC)
        
        // Access the SceneDelegate to change the root view controller
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            // Set HomeViewController as the root view controller
            sceneDelegate.window?.rootViewController = navigationController
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }
    
}
