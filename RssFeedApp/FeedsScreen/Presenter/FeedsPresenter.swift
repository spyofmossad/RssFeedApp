//
//  FeedsPresenter.swift
//  RssFeedApp
//
//  Created by Dmitry on 18.11.2020.
//

import Foundation

protocol FeedsPresenterProtocol: class {
    var numberOfSections: Int { get }
    
    init(dataProvider: DataProviderProtocol, coordinator: Coordinator, view: FeedsViewProtocol)
    
    func updateUI()
    func onTapAddFeed()
    func onTapEditFeed(at indexPath: IndexPath)
    func onTapDelete(at indexPath: IndexPath)
    func onTapAddFolder()
    
    func titleForHeaderInSection(_ section: Int) -> String
    func numberOfRowsInSection(_ section: Int) -> Int
    func indexPaths(for section: Int) -> [IndexPath]
    
    func headerPresenter(for section: Int) -> FeedsTableHeaderPresenterProtocol
    func headerOnTap(section: Int)
    func headerOnLongTap(section: Int)
    func heightForHeaderInSection(section: Int) -> Int
    
    func didSelectRowAt(indexPath: IndexPath)
    
    func cellTitleAt(indexPath: IndexPath) -> String
    func cellCategoryAt(indexPath: IndexPath) -> String
    func cellNewsCountAt(indexPath: IndexPath) -> String
}

class FeedsPresenter: FeedsPresenterProtocol {
    
    private let dataProvider: DataProviderProtocol
    private let coordinator: Coordinator
    
    private unowned var view: FeedsViewProtocol
    
    var numberOfSections: Int {
        return dataProvider.foldersList.count
    }
    
    required init(dataProvider: DataProviderProtocol, coordinator: Coordinator, view: FeedsViewProtocol) {
        self.dataProvider = dataProvider
        self.coordinator = coordinator
        self.view = view
    }
    
    func updateUI() {
        if dataProvider.foldersList.contains(where: {$0.name != Constants.defaultFolder}) || dataProvider.feedsList.count > 0 {
            view.updateUI()
        } else {
            view.showPlaceholder(with: R.string.localizable.noFeedsPlaceholder())
        }
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return dataProvider.foldersList[section].feeds.count
    }
    
    func onTapDelete(at indexPath: IndexPath) {
        let feed = dataProvider.foldersList[indexPath.section].feeds[indexPath.row]
        dataProvider.delete(entity: feed)
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
    
    func headerOnTap(section: Int) {
        view.expandCollapse(section)
    }
    
    func heightForHeaderInSection(section: Int) -> Int {
        if dataProvider.foldersList[section].name == Constants.defaultFolder { return 0 }
        return 44
    }
    
    func cellTitleAt(indexPath: IndexPath) -> String {
        return dataProvider.foldersList[indexPath.section].feeds[indexPath.row].title
    }
    
    func cellCategoryAt(indexPath: IndexPath) -> String {
        dataProvider.foldersList[indexPath.section].feeds[indexPath.row].categories.joined(separator: ", ")
    }
    
    func cellNewsCountAt(indexPath: IndexPath) -> String {
        dataProvider.foldersList[indexPath.section].feeds[indexPath.row].news.filter({$0.read == false}).count.description
    }
    
    // MARK: - Navigation
    func onTapAddFeed() {
        coordinator.goToAddEditFeedScreen(feed: nil)
    }
    
    func onTapEditFeed(at indexPath: IndexPath) {
        coordinator.goToAddEditFeedScreen(feed: dataProvider.foldersList[indexPath.section].feeds[indexPath.row])
    }
    
    func onTapAddFolder() {
        coordinator.goToAddEditFolderScreen(folder: nil)
    }
    
    func headerOnLongTap(section: Int) {
        let folder = dataProvider.foldersList[section]
        coordinator.goToAddEditFolderScreen(folder: folder)
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        let feed = dataProvider.foldersList[indexPath.section].feeds[indexPath.row]
        coordinator.goToNewsScren(feed: feed)
    }
}
