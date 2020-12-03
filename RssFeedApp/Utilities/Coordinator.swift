//
//  Coordinator.swift
//  RssFeedApp
//
//  Created by Dmitry on 17.11.2020.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    var screenBuilder: ScreenBuilderProtocol { get set }
    func start()
    func popToRoot()
}

class AppCoordinator: Coordinator {
    var screenBuilder: ScreenBuilderProtocol
    var navigationController: UINavigationController
        
    init(naviationController: UINavigationController, screenBuilder: ScreenBuilderProtocol) {
        self.navigationController = naviationController
        self.screenBuilder = screenBuilder
    }
    
    func start() {
        goToFeedsView()
    }
    
    func goToFeedsView() {
        let feedsView = screenBuilder.feedsView(coordinator: self)
        navigationController.setViewControllers([feedsView], animated: false)
    }
    
    func goToAddEditFeedScreen(feed: RealmRss?) {
        let addFeedView = screenBuilder.addEditFeedView(coordinator: self, feed: feed)
        navigationController.pushViewController(addFeedView, animated: true)
    }
    
    func goToAddEditFolderScreen() {
        let addEditFolder = UIStoryboard.init(name: "AddEditFolder", bundle: nil).instantiateViewController(identifier: "AddEditFolderViewController") as! AddEditFolderViewController
        navigationController.pushViewController(addEditFolder, animated: true)
    }
    
    func goToNewsScren() {
        let news = UIStoryboard.init(name: "News", bundle: nil).instantiateViewController(identifier: "NewsViewController") as! NewsViewController
        news.delegate = self
        navigationController.pushViewController(news, animated: true)
    }
    
    func goToNewsDetailsScreen() {
        let newsDetails = UIStoryboard.init(name: "NewsDetails", bundle: nil).instantiateViewController(identifier: "NewsDetailsViewController") as! NewsDetailsViewController
        navigationController.pushViewController(newsDetails, animated: true)
    }
    
    func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }

}

extension AppCoordinator: NewsDelegate {
    func openNewsDetails() {
        goToNewsDetailsScreen()
    }
    
    
}
