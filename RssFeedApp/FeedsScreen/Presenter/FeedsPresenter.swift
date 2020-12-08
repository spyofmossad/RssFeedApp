//
//  FeedsPresenter.swift
//  RssFeedApp
//
//  Created by Dmitry on 18.11.2020.
//

import Foundation

protocol FeedsViewProtocol: class {
    func expandCollapse(_ section: Int)
}

protocol FeedsPresenterProtocol: class {
    var numberOfSections: Int { get }
    
    init(dataProvider: DataProviderProtocol, coordinator: AppCoordinator, view: FeedsViewProtocol)
    
    func onTapAddFeed()
    func onTapEditFeed(at indexPath: IndexPath)
    func deleteFeed(at indexPath: IndexPath)
    func onTapAddFolder()
    
    func titleForHeaderInSection(_ section: Int) -> String
    func numberOfRowsInSection(_ section: Int) -> Int
    func indexPaths(for section: Int) -> [IndexPath]
    
    func headerPresenter(for section: Int) -> FeedsTableHeaderPresenterProtocol
    func cellPresenter(for indexPath: IndexPath) -> FeedsTableCellPresenterProtocol
    func headerOnTap(section: Int)
    func headerOnLongTap(section: Int)
    func heightForHeaderInSection(section: Int) -> Int
}

class FeedsPresenter: FeedsPresenterProtocol {
    
    private let dataProvider: DataProviderProtocol
    private let coordinator: AppCoordinator
    
    private unowned var view: FeedsViewProtocol
    
    var numberOfSections: Int {
        return dataProvider.foldersList.count
    }
    
    required init(dataProvider: DataProviderProtocol, coordinator: AppCoordinator, view: FeedsViewProtocol) {
        self.dataProvider = dataProvider
        self.coordinator = coordinator
        self.view = view
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return dataProvider.foldersList[section].feeds.count
    }
    
    func deleteFeed(at indexPath: IndexPath) {
        let deletedFeed = dataProvider.feedsList[indexPath.row]
        dataProvider.delete(feed: deletedFeed)
    }
    
    func titleForHeaderInSection(_ section: Int) -> String {
        return dataProvider.foldersList[section].name
    }
    
    func indexPaths(for section: Int) -> [IndexPath] {
        var indexPaths = [IndexPath]()
        for row in 0..<dataProvider.foldersList[section].feeds.count {
            indexPaths.append(IndexPath(row: row, section: section))
        }
        
        return indexPaths
    }
    
    func headerPresenter(for section: Int) -> FeedsTableHeaderPresenterProtocol {
        return TableHeaderPresenter(parentPresenter: self, section: section)
    }
    
    func cellPresenter(for indexPath: IndexPath) -> FeedsTableCellPresenterProtocol {
        let feed = dataProvider.foldersList[indexPath.section].feeds[indexPath.row]
        return FeedsTableCellPresenter(feed: feed)
    }
    
    func headerOnTap(section: Int) {
        view.expandCollapse(section)
    }
    
    func heightForHeaderInSection(section: Int) -> Int {
        if dataProvider.foldersList[section].name == Constants.defaultFolder { return 0 }
        return 44
    }
    
    // MARK: - Navigation
    func onTapAddFeed() {
        coordinator.goToAddEditFeedScreen(feed: nil)
    }
    
    func onTapEditFeed(at indexPath: IndexPath) {
        coordinator.goToAddEditFeedScreen(feed: dataProvider.feedsList[indexPath.row])
    }
    
    func onTapAddFolder() {
        coordinator.goToAddEditFolderScreen(folder: nil)
    }
    
    func headerOnLongTap(section: Int) {
        let folder = dataProvider.foldersList[section]
        coordinator.goToAddEditFolderScreen(folder: folder)
    }
}

