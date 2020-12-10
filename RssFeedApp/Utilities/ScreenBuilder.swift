//
//  SceneBuilder.swift
//  RssFeedApp
//
//  Created by Dmitry on 18.11.2020.
//

import Foundation
import UIKit

protocol ScreenBuilderProtocol: class {
    init(dataProvider: DataProviderProtocol, networkService: NetworkServiceProtocol)
    func feedsView(coordinator: AppCoordinator) -> UIViewController
    func addEditFeedView(coordinator: AppCoordinator, feed: RealmRss?) -> UIViewController
    func addEditFolderView(coordinator: AppCoordinator, folder: Folder?) -> UIViewController
    func newsView(coordinator: AppCoordinator, news: [RealmNews]) -> UIViewController
}

class ScreenBuilder: ScreenBuilderProtocol {
    private var dataProvider: DataProviderProtocol
    private var networkService: NetworkServiceProtocol
    
    required init(dataProvider: DataProviderProtocol, networkService: NetworkServiceProtocol) {
        self.dataProvider = dataProvider
        self.networkService = networkService
    }
    
    func feedsView(coordinator: AppCoordinator) -> UIViewController {
        let feedsView = FeedsViewController.instantiate()
        let feedsPresenter = FeedsPresenter(dataProvider: dataProvider, coordinator: coordinator, view: feedsView)
        feedsView.presenter = feedsPresenter
        
        return feedsView
    }
    
    func addEditFeedView(coordinator: AppCoordinator, feed: RealmRss?) -> UIViewController {
        let addEditFeedView = AddEditFeedViewController.instantiate()
        let addEditFeedPresenter = AddEditFeedPresenter(dataProvider: dataProvider, networkService: networkService, coordinator: coordinator, view: addEditFeedView, rss: feed)
        addEditFeedView.presenter = addEditFeedPresenter
        
        return addEditFeedView
    }
    
    func addEditFolderView(coordinator: AppCoordinator, folder: Folder?) -> UIViewController {
        let addEditFolderView = AddEditFolderViewController.instantiate()
        let addEditFolderPresenter = AddEditFolderPresenter(dataProvider: dataProvider, coordinator: coordinator, view: addEditFolderView, folder: folder)
        addEditFolderView.presenter = addEditFolderPresenter
        
        return addEditFolderView
    }
    
    func newsView(coordinator: AppCoordinator, news: [RealmNews]) -> UIViewController {
        let newsView = NewsViewController.instantiate()
        let newsViewPresenter = NewsViewPresenter(dataProvider: dataProvider, networkService: networkService, coordinator: coordinator, view: newsView, news: news)
        newsView.presenter = newsViewPresenter
        
        return newsView
    }
}
