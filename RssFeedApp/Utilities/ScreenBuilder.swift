//
//  SceneBuilder.swift
//  RssFeedApp
//
//  Created by Dmitry on 18.11.2020.
//

import Foundation
import UIKit

protocol ScreenBuilderProtocol: class {
    func feedsView(coordinator: AppCoordinator) -> UIViewController
    func addEditFeedView(coordinator: AppCoordinator, feed: RealmRss?) -> UIViewController
    init(dataProvider: DataProviderProtocol)
}

class ScreenBuilder: ScreenBuilderProtocol {
    private var dataProvider: DataProviderProtocol
    
    required init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    func feedsView(coordinator: AppCoordinator) -> UIViewController {
        let feedsPresenter = FeedsPresenter(dataProvider: dataProvider, coordinator: coordinator)
        let feedsView = UIStoryboard.init(name: "Feeds", bundle: nil).instantiateViewController(identifier: "FeedsViewController") { (coder) in
            return FeedsViewController(coder: coder, presenter: feedsPresenter)
        }
        feedsPresenter.view = feedsView
        
        return feedsView
    }
    
    func addEditFeedView(coordinator: AppCoordinator, feed: RealmRss?) -> UIViewController {
        let addFeedPresenter = AddFeedPresenter(dataProvider: dataProvider, coordinator: coordinator, rss: feed)
        let addFeedView = UIStoryboard.init(name: "AddEditFeed", bundle: nil).instantiateViewController(identifier: "AddEditFeedViewController") { (coder) in
            return AddEditFeedViewController(coder: coder, presenter: addFeedPresenter)
        }
        addFeedPresenter.view = addFeedView
        
        return addFeedView
    }
}
