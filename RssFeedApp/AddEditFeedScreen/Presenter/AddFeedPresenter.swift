//
//  AddFeedPresenter.swift
//  RssFeedApp
//
//  Created by Dmitry on 18.11.2020.
//

import Foundation

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
    init(dataProvider: DataProviderProtocol, coordinator: AppCoordinator, rss: Rss?)
    func textFieldShouldReturn(userInput: String?)
    func saveChanges()
    func setRss()
}

class AddFeedPresenter: AddFeedPresenterProtocol {
    weak var view: AddFeedViewProtocol?
    
    private var dataProvider: DataProviderProtocol
    private var coordinator: AppCoordinator
    private var networkService: Network
    private var rss: Rss?
    private var newRss: Rss?
    
    private var isEdit = false
    
    required init(dataProvider: DataProviderProtocol, coordinator: AppCoordinator, rss: Rss?) {
        self.coordinator = coordinator
        self.dataProvider = dataProvider
        self.rss = rss
        networkService = NetworkService()
        
        if rss != nil {
            isEdit = true
        }
    }
    
    func textFieldShouldReturn(userInput: String?) {
        guard let userInput = userInput else { return }
        view?.showSpinner()
        networkService.fetchData(from: userInput) { (result) in
            DispatchQueue.main.async {
                self.view?.removeSpinner()
                switch result {
                case .success(let feed):
                    self.newRss = feed
                    self.newRss?.channel.url = userInput
                    self.view?.showTitle(title: feed?.channel.title)
                    if let categories = feed?.channel.categories {
                        self.view?.showCategories(categories: categories)
                    } else {
                        self.view?.showPlaceholder()
                    }
                    self.view?.activateSaveButton()
                case .failure(let error):
                    self.view?.showError(message: error.localizedDescription)
                }
            }
        }
    }
    
    func saveChanges() {
        if let newRss = newRss {
            isEdit ? dataProvider.update(old: rss!, with: newRss) : dataProvider.saveFeed(feed: newRss)
        }
        coordinator.popToRoot()
    }
    
    func setRss() {
        if let rss = rss {
            self.view?.showUrl(url: rss.channel.url)
            self.view?.showTitle(title: rss.channel.title)
            
            if let categories = rss.channel.categories {
                self.view?.showCategories(categories: categories)
            } else {
                self.view?.showPlaceholder()
            }
        }
    }
}
