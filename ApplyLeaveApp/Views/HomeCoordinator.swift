//
//  HomeCoordinator.swift
//  ApplyLeaveApp
//
//  Created by Vandana's MacbookAir on 22/11/24.
//

import Foundation

class HomeCoordinator {

    var homeViewController: HomeViewController

    init(homeViewController: HomeViewController) {
        self.homeViewController = homeViewController
    }

    func navigateTo(screen: Screen) {
        homeViewController.displayScreen(screen)
    }
}
