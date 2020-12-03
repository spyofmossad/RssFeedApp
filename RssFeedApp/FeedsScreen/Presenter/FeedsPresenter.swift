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
    var rssFeeds: [Rss]? { get set }
    
    init(dataProvider: DataProviderProtocol, coordinator: AppCoordinator)
    
    func getFeeds()
    func onTapAddFeed()
    func getFeedsCount() -> Int?
    func getTitle(indexPath: IndexPath) -> String?
    func getCategories(indexPath: IndexPath) -> String?
    func deleteRows(at indexPath: IndexPath)
    func onTapEditFeed(at indexPath: IndexPath)
}

class FeedsPresenter: FeedsPresenterProtocol {
    weak var view: FeedsViewProtocol?
    let dataProvider: DataProviderProtocol
    let coordinator: AppCoordinator
    var rssFeeds: [Rss]?
    
    required init(dataProvider: DataProviderProtocol, coordinator: AppCoordinator) {
        self.dataProvider = dataProvider
        self.coordinator = coordinator
    }
    
    func getFeeds() {
        dataProvider.getFeeds { [weak self] (feeds) in
            guard let self = self else { return }
            self.rssFeeds = feeds
            self.view?.updateView()
        }
    }
    
    func getTitle(indexPath: IndexPath) -> String? {
        let title = rssFeeds?[indexPath.row].channel.title
        return title
    }
    
    func getCategories(indexPath: IndexPath) -> String? {
        let categories = rssFeeds?[indexPath.row].channel.categories?.first
        return categories
    }
    
    func getFeedsCount() -> Int? {
        return rssFeeds?.count
    }
    
    func deleteRows(at indexPath: IndexPath) {
        rssFeeds?.remove(at: indexPath.row)
        dataProvider.deleteFeed(at: indexPath.row)
    }
    
    // MARK - Navigation
    func onTapAddFeed() {
        coordinator.goToAddEditFeedScreen(feed: nil)
    }
    
    func onTapEditFeed(at indexPath: IndexPath) {
        coordinator.goToAddEditFeedScreen(feed: rssFeeds![indexPath.row])
    }
}

