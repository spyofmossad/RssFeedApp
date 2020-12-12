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
    
    func goToAddEditFolderScreen(folder: Folder?) {
        let addEditFolderView = screenBuilder.addEditFolderView(coordinator: self, folder: folder)
        navigationController.pushViewController(addEditFolderView, animated: true)
    }
    
    func goToNewsScren(news: [RealmNews]) {
        let newsView = screenBuilder.newsView(coordinator: self, news: news)
        navigationController.pushViewController(newsView, animated: true)
    }
    
    func goToNewsDetailsScreen(news: RealmNews) {
        let newsDetailsView = screenBuilder.newsDetailsView(coordinator: self, news: news)
        navigationController.pushViewController(newsDetailsView, animated: true)
    }
    
    func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
}
