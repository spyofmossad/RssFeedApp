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
        guard let textFieldText = textFieldText, !textFieldText.isEmpty else {
            self.view.disableSaveButton()
            return
        }
        if tag == 0 {
            view.showSpinner()
            networkService.fetchData(from: textFieldText) { (result) in
                DispatchQueue.main.async {
                    self.view.removeSpinner()
                    switch result {
                    case .success(let feed):
                        if let feed = feed {
                            self.newFeed = feed
                            self.newFeed?.url = textFieldText
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
            guard currentFeed != nil else { return }
            if textFieldText == " " {
                self.view.disableSaveButton()
            } else {
                self.view.activateSaveButton()
            }
        }
    }
    
    func saveChanges() {
        if let currentFeed = currentFeed {
            if let newFeed = newFeed {
                dataProvider.replace(old: currentFeed, with: newFeed)
            } else {
                dataProvider.update(feed: currentFeed, view.feedUrl, view.feedTitleText, view.feedCategories)
            }
        } else if let newFeed = newFeed {
            newFeed.title = view.feedTitleText
            dataProvider.save(feed: newFeed, to: nil)
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
