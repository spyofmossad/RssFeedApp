//
//  SceneBuilder.swift
//  RssFeedApp
//
//  Created by Dmitry on 18.11.2020.
//

import Foundation
import UIKit

protocol ScreenBuilderProtocol {
    func feedsView(coordinator: AppCoordinator) -> UIViewController
    func addEditFeedView(coordinator: AppCoordinator, feed: Rss?) -> UIViewController
}

class ScreenBuilder: ScreenBuilderProtocol {
    func feedsView(coordinator: AppCoordinator) -> UIViewController {
        let dataProvider = DataProvider.shared
        let feedsPresenter = FeedsPresenter(dataProvider: dataProvider, coordinator: coordinator)
        let feedsView = UIStoryboard.init(name: "Feeds", bundle: nil).instantiateViewController(identifier: "FeedsViewController") { (coder) in
            return FeedsViewController(coder: coder, presenter: feedsPresenter)
        }
        feedsPresenter.view = feedsView
        
        return feedsView
    }
    
    func addEditFeedView(coordinator: AppCoordinator, feed: Rss?) -> UIViewController {
        let dataProvider = DataProvider.shared
        let addFeedPresenter = AddFeedPresenter(dataProvider: dataProvider, coordinator: coordinator, rss: feed)
        let addFeedView = UIStoryboard.init(name: "AddEditFeed", bundle: nil).instantiateViewController(identifier: "AddEditFeedViewController") { (coder) in
            return AddEditFeedViewController(coder: coder, presenter: addFeedPresenter)
        }
        addFeedPresenter.view = addFeedView
        
        return addFeedView
    }
}
