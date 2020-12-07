//
//  AddFeedPresenter.swift
//  RssFeedApp
//
//  Created by Dmitry on 18.11.2020.
//

import Foundation
import RealmSwift

protocol AddFeedViewProtocol: class {
    func saveChanges()
    func showSpinner()
    func removeSpinner()
    func showError(message: String)
    func showTitle(title: String?)
    func showUrl(url: String?)
    func showCategories(categories: [String])
    func showPlaceholder()
    func activateSaveButton()
}

protocol AddFeedPresenterProtocol: class {
    init(dataProvider: DataProviderProtocol, networkService: NetworkServiceProtocol, coordinator: AppCoordinator, view: AddFeedViewProtocol, rss: RealmRss?)
    func textFieldShouldReturn(userInput: String?)
    func saveChanges()
    func updateUI()
}

class AddEditFeedPresenter: AddFeedPresenterProtocol {
    
    private unowned var view: AddFeedViewProtocol
    
    private var dataProvider: DataProviderProtocol
    private var coordinator: AppCoordinator
    private var networkService: NetworkServiceProtocol
    
    private var currentFeed: RealmRss?
    private var newFeed: RealmRss?
        
    required init(dataProvider: DataProviderProtocol, networkService: NetworkServiceProtocol, coordinator: AppCoordinator, view: AddFeedViewProtocol, rss: RealmRss?) {
        self.coordinator = coordinator
        self.dataProvider = dataProvider
        self.networkService = networkService
        self.view = view
        self.currentFeed = rss
    }
    
    func textFieldShouldReturn(userInput: String?) {
        guard let userInput = userInput else { return }
        view.showSpinner()
        networkService.fetchData(from: userInput) { (result) in
            DispatchQueue.main.async {
                self.view.removeSpinner()
                switch result {
                case .success(let feed):
                    
                    self.newFeed = RealmRss()
                    self.newFeed?.title = feed?.channel.title ?? ""
                    self.newFeed?.url = userInput
                    self.newFeed?.categories.append(objectsIn: feed?.channel.categories ?? [])
                    
                    self.updateUI()
                    self.view.activateSaveButton()
                
                case .failure(let error):
                    self.view.showError(message: error.localizedDescription)
                }
            }
        }
    }
    
    func saveChanges() {
        if let currentFeed = currentFeed {
            dataProvider.update(feed: currentFeed, with: newFeed!)
        }
        if let newFeed = newFeed {
            let defaultFolder = dataProvider.foldersList.filter("name == 'Default'").first
            if let defaultFolder = defaultFolder {
                dataProvider.save(feed: newFeed, to: defaultFolder)
            } else {
                let defaultFolder = Folder()
                defaultFolder.name = "Default"
                dataProvider.save(folder: defaultFolder)
                dataProvider.save(feed: newFeed, to: defaultFolder)
            }
        }
        coordinator.popToRoot()
    }
    
    func updateUI() {
        [currentFeed, newFeed].forEach { (feed) in
            if let feed = feed {
                self.view.showUrl(url: feed.url)
                self.view.showTitle(title: feed.title)
                
                feed.categories.count > 0 ?
                    self.view.showCategories(categories: Array(feed.categories)) :
                    self.view.showPlaceholder()
            }
        }
    }
}
