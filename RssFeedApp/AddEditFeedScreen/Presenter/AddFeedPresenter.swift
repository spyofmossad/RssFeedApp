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
    init(dataProvider: DataProviderProtocol, coordinator: AppCoordinator, rss: RealmRss?)
    func textFieldShouldReturn(userInput: String?)
    func saveChanges()
    func updateUI()
}

class AddFeedPresenter: AddFeedPresenterProtocol {
    weak var view: AddFeedViewProtocol?
    
    private var dataProvider: DataProviderProtocol
    private var coordinator: AppCoordinator
    private var networkService: Network
    
    private var currentFeed: RealmRss?
    private var newFeed: RealmRss?
        
    required init(dataProvider: DataProviderProtocol, coordinator: AppCoordinator, rss: RealmRss?) {
        self.coordinator = coordinator
        self.dataProvider = dataProvider
        self.currentFeed = rss
        networkService = NetworkService()
    }
    
    func textFieldShouldReturn(userInput: String?) {
        guard let userInput = userInput else { return }
        view?.showSpinner()
        networkService.fetchData(from: userInput) { (result) in
            DispatchQueue.main.async {
                self.view?.removeSpinner()
                switch result {
                case .success(let feed):
                    self.newFeed = RealmRss()
                    self.newFeed?.title = feed?.channel.title ?? ""
                    self.newFeed?.url = userInput
                    self.newFeed?.categories.append(objectsIn: feed?.channel.categories ?? [])
                    
                    self.updateUI()
                    self.view?.activateSaveButton()
                case .failure(let error):
                    self.view?.showError(message: error.localizedDescription)
                }
            }
        }
    }
    
    func saveChanges() {
        if let currentFeed = currentFeed {
            dataProvider.update(feed: currentFeed, with: newFeed!)
        } else {
            dataProvider.save(feed: newFeed!)
        }
        
        coordinator.popToRoot()
    }
    
    func updateUI() {
        [currentFeed, newFeed].forEach { (feed) in
            if let feed = feed {
                self.view?.showUrl(url: feed.url)
                self.view?.showTitle(title: feed.title)
                
                feed.categories.count > 0 ?
                    self.view?.showCategories(categories: Array(feed.categories)) :
                    self.view?.showPlaceholder()
            }
        }
    }
}
