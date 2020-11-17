//
//  Coordinator.swift
//  RssFeedApp
//
//  Created by Dmitry on 17.11.2020.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator {
    private var navController: UINavigationController
    
    init(naviationController: UINavigationController) {
        self.navController = naviationController
    }
    
    func start() {
        let mainVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "MainViewController") as! MainViewController
        mainVC.delegate = self
        navController.setViewControllers([mainVC], animated: false)
    }
    
    func initAddEditFeed() {
        let addEditFeed = UIStoryboard.init(name: "AddEditFeed", bundle: nil).instantiateViewController(identifier: "AddEditFeedViewController") as! AddEditFeedViewController
        navController.pushViewController(addEditFeed, animated: true)
    }
    
    func initAddEditFolder() {
        let addEditFolder = UIStoryboard.init(name: "AddEditFolder", bundle: nil).instantiateViewController(identifier: "AddEditFolderViewController") as! AddEditFolderViewController
        navController.pushViewController(addEditFolder, animated: true)
    }

}

extension AppCoordinator: MainViewDelegate {
    func openAddFolder() {
        initAddEditFolder()
    }
    
    func openAddFeed() {
        initAddEditFeed()
    }
    
    
}
