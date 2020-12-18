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
    func feedsView(coordinator: Coordinator) -> UIViewController
    func addEditFeedView(coordinator: Coordinator, feed: Feed?) -> UIViewController
    func addEditFolderView(coordinator: Coordinator, folder: Folder?) -> UIViewController
    func newsView(coordinator: Coordinator, feed: Feed) -> UIViewController
    func newsFilterView(coordinator: Coordinator, filter: Filter) -> UIViewController
    func newsDetailsView(coordinator: Coordinator, news: News) -> UIViewController
}

class ScreenBuilder: ScreenBuilderProtocol {
    private var dataProvider: DataProviderProtocol
    private var networkService: NetworkServiceProtocol
    
    required init(dataProvider: DataProviderProtocol, networkService: NetworkServiceProtocol) {
        self.dataProvider = dataProvider
        self.networkService = networkService
    }
    
    func feedsView(coordinator: Coordinator) -> UIViewController {
        let feedsView = FeedsViewController.instantiate()
        let feedsPresenter = FeedsPresenter(dataProvider: dataProvider, coordinator: coordinator, view: feedsView)
        feedsView.presenter = feedsPresenter
        
        return feedsView
    }
    
    func addEditFeedView(coordinator: Coordinator, feed: Feed?) -> UIViewController {
        let addEditFeedView = AddEditFeedViewController.instantiate()
        let addEditFeedPresenter = AddEditFeedPresenter(dataProvider: dataProvider, networkService: networkService, coordinator: coordinator, view: addEditFeedView, rss: feed)
        addEditFeedView.presenter = addEditFeedPresenter
        
        return addEditFeedView
    }
    
    func addEditFolderView(coordinator: Coordinator, folder: Folder?) -> UIViewController {
        let addEditFolderView = AddEditFolderViewController.instantiate()
        let addEditFolderPresenter = AddEditFolderPresenter(dataProvider: dataProvider, coordinator: coordinator, view: addEditFolderView, folder: folder)
        addEditFolderView.presenter = addEditFolderPresenter
        
        return addEditFolderView
    }
    
    func newsView(coordinator: Coordinator, feed: Feed) -> UIViewController {
        let newsView = NewsViewController.instantiate()
        let newsViewPresenter = NewsViewPresenter(dataProvider: dataProvider, networkService: networkService, coordinator: coordinator, view: newsView, feed: feed)
        newsView.presenter = newsViewPresenter
        
        return newsView
    }
    
    func newsFilterView(coordinator: Coordinator, filter: Filter) -> UIViewController {
        let newsFilterView = NewsFilterViewController.instantiate()
        let newsFilterPresenter = NewsFilterPresenter(coordinator: coordinator,dataProvider: dataProvider, view: newsFilterView, filter: filter)
        newsFilterView.presenter = newsFilterPresenter
        
        return newsFilterView
    }
    
    func newsDetailsView(coordinator: Coordinator, news: News) -> UIViewController {
        let newsDetailsView = NewsDetailsViewController.instantiate()
        let newsDetailsPresenter = NewsDetailsPresenter(dataProvider: dataProvider, coordinator: coordinator, view: newsDetailsView, news: news)
        newsDetailsView.presenter = newsDetailsPresenter
        
        return newsDetailsView
    }
}
