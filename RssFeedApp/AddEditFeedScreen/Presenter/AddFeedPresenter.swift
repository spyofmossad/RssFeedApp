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
    func showCategories(categories: [String])
    func showPlaceholder()
    func activateSaveButton()
}

protocol AddFeedPresenterProtocol: class {
    init(dataProvider: DataProviderProtocol, coordinator: AppCoordinator)
    func textFieldShouldReturn(userInput: String?)
    func saveChanges()
}

class AddFeedPresenter: AddFeedPresenterProtocol {
    
    weak var view: AddFeedViewProtocol?
    
    private var dataProvider: DataProviderProtocol
    private var coordinator: AppCoordinator
    private var networkService: Network
    private var rss: Rss?
    
    required init(dataProvider: DataProviderProtocol, coordinator: AppCoordinator) {
        self.coordinator = coordinator
        self.dataProvider = dataProvider
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
                    self.rss = feed
                    self.rss?.channel.url = userInput
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
        if let rss = rss {
            dataProvider.saveFeed(feed: rss)
        }
        coordinator.popToRoot()
    }
}
