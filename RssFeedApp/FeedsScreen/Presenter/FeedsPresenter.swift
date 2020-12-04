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
    
    
    
    func onTapAddFeed()
    func deleteFeed(at indexPath: IndexPath)
    func onTapEditFeed(at indexPath: IndexPath)
    
    func onTapAddFolder()
    
    func numberOfSections() -> Int?
    func titleForHeaderInSection(_ section: Int) -> String
    func numberOfRowsInSection(_ section: Int) -> Int?
    func getTitle(indexPath: IndexPath) -> String?
    func getCategories(indexPath: IndexPath) -> String?
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
        return dataProvider.foldersList[indexPath.section].feeds[indexPath.row].title
    }
    
    func getCategories(indexPath: IndexPath) -> String? {
        return dataProvider.foldersList[indexPath.section].feeds[indexPath.row].categories.joined(separator: ",")
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int? {
        return dataProvider.foldersList[section].feeds.count
    }
    
    func deleteFeed(at indexPath: IndexPath) {
        let deletedFeed = dataProvider.feedsList[indexPath.row]
        dataProvider.delete(feed: deletedFeed)
    }
    
    func numberOfSections() -> Int? {
        return dataProvider.foldersList.count
    }
    
    func titleForHeaderInSection(_ section: Int) -> String {
        return dataProvider.foldersList[section].name
    }
    
    // MARK: - Navigation
    func onTapAddFeed() {
        coordinator.goToAddEditFeedScreen(feed: nil)
    }
    
    func onTapEditFeed(at indexPath: IndexPath) {
        coordinator.goToAddEditFeedScreen(feed: dataProvider.feedsList[indexPath.row])
    }
    
    func onTapAddFolder() {
        coordinator.goToAddEditFolderScreen()
    }
}

