//
//  FeedsPresenter.swift
//  RssFeedApp
//
//  Created by Dmitry on 18.11.2020.
//

import Foundation

protocol FeedsViewProtocol: class {
    func updateView()
}

protocol FeedsPresenterProtocol: class {
    init(dataProvider: DataProviderProtocol, coordinator: AppCoordinator)
    
    func getFeedsCount() -> Int?
    func getTitle(indexPath: IndexPath) -> String?
    func getCategories(indexPath: IndexPath) -> String?
    
    func onTapAddFeed()
    func deleteFeed(at indexPath: IndexPath)
    func onTapEditFeed(at indexPath: IndexPath)
}

class FeedsPresenter: FeedsPresenterProtocol {
    weak var view: FeedsViewProtocol?
    let dataProvider: DataProviderProtocol
    let coordinator: AppCoordinator
    
    required init(dataProvider: DataProviderProtocol, coordinator: AppCoordinator) {
        self.dataProvider = dataProvider
        self.coordinator = coordinator
    }
    
    func getTitle(indexPath: IndexPath) -> String? {
        return dataProvider.feedsList[indexPath.row].title
    }
    
    func getCategories(indexPath: IndexPath) -> String? {
        return dataProvider.feedsList[indexPath.row].categories.joined(separator: ",")
    }
    
    func getFeedsCount() -> Int? {
        return dataProvider.feedsList.count
    }
    
    func deleteFeed(at indexPath: IndexPath) {
        let deletedFeed = dataProvider.feedsList[indexPath.row]
        dataProvider.delete(feed: deletedFeed)
    }
    
    // MARK - Navigation
    func onTapAddFeed() {
        coordinator.goToAddEditFeedScreen(feed: nil)
    }
    
    func onTapEditFeed(at indexPath: IndexPath) {
        coordinator.goToAddEditFeedScreen(feed: dataProvider.feedsList[indexPath.row])
    }
}

