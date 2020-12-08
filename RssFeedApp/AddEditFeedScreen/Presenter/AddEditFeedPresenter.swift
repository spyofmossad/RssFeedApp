//
//  AddFeedPresenter.swift
//  RssFeedApp
//
//  Created by Dmitry on 18.11.2020.
//

import Foundation

protocol AddFeedViewProtocol: class {
    var feedTitleText: String { get }
    var feedUrl: String { get }
    var feedCategories: [String] { get }
    
    func updateUI(url: String, title: String, categories: [String])
    func saveChanges()
    func showSpinner()
    func removeSpinner()
    func showError(message: String)
    func showPlaceholder()
    func activateSaveButton()
    func disableSaveButton()
}

protocol AddFeedPresenterProtocol: class {
    init(dataProvider: DataProviderProtocol, networkService: NetworkServiceProtocol, coordinator: AppCoordinator, view: AddFeedViewProtocol, rss: RealmRss?)
    func textFieldShouldReturn(tag: Int, textFieldText: String?)
    func saveChanges()
    func viewDidLoad()
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
    
    func textFieldShouldReturn(tag: Int, textFieldText: String?) {
        if tag == 0 {
            guard let textFieldText = textFieldText, !textFieldText.isEmpty else { return }
            view.showSpinner()
            networkService.fetchData(from: textFieldText) { (result) in
                DispatchQueue.main.async {
                    self.view.removeSpinner()
                    switch result {
                    case .success(let feed):
                        if let feed = feed {
                            self.view.updateUI(url: textFieldText, title: feed.title, categories: Array(feed.categories))
                        }
                        self.view.activateSaveButton()
                    case .failure(let error):
                        self.view.showError(message: error.localizedDescription)
                        self.view.disableSaveButton()
                    }
                    return
                }
            }
        }
        if tag == 1 {
            guard let textFieldText = textFieldText, let currentFeed = currentFeed else { return }
            if currentFeed.title != textFieldText {
                self.view.activateSaveButton()
            } else {
                self.view.disableSaveButton()
            }
        }
    }
    
    func saveChanges() {
        if let currentFeed = currentFeed {
            dataProvider.update(feed: currentFeed, new: view.feedUrl, new: view.feedTitleText, new: view.feedCategories)
        } else {
            let feed = RealmRss()
            feed.url = view.feedUrl
            feed.title = view.feedTitleText
            feed.categories.append(objectsIn: view.feedCategories)
            dataProvider.save(feed: feed, to: nil)
        }
        coordinator.popToRoot()
    }
    
    func viewDidLoad() {
        if let feed = currentFeed {
            self.view.updateUI(url: feed.url, title: feed.title, categories: Array(feed.categories))
        } else {
            self.view.showPlaceholder()
        }
    }
}
