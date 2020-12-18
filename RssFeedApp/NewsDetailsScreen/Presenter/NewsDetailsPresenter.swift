//
//  Presenter.swift
//  RssFeedApp
//
//  Created by Dmitry on 12.12.2020.
//

import Foundation

protocol NewsDetailsViewProtocol: class {
    func updateUI(imageUrl: String, title: String, descr: String, favorite: Bool)
    func updateTabBar(addToFav: Bool)
    func favOnTap()
    func shareOnTap()
    func safariOnTap()
    func openSafari(url: URL)
    func share(url: URL)
    func showAlert(title: String, text: String)
}

protocol NewsDetailsPresenterProtocol {
    init(dataProvider: DataProviderProtocol, coordinator: Coordinator, view: NewsDetailsViewProtocol, news: News)
    func updateUI()
    func safariOnTap()
    func favOnTap()
    func shareOnTap()
}

class NewsDetailsPresenter: NewsDetailsPresenterProtocol {
    private unowned var view: NewsDetailsViewProtocol
    private var coordinator: Coordinator
    private var dataProvider: DataProviderProtocol
    private var news: News
    
    required init(dataProvider: DataProviderProtocol, coordinator: Coordinator, view: NewsDetailsViewProtocol, news: News) {
        self.coordinator = coordinator
        self.dataProvider = dataProvider
        self.view = view
        self.news = news
        dataProvider.update(news: self.news, isRead: true)
    }
    
    func updateUI() {
        view.updateUI(imageUrl: news.imageUrl, title: news.title, descr: news.newsDescription, favorite: news.favorite)
    }
    
    func safariOnTap() {
        if let url = URL(string: news.link) {
            return view.openSafari(url: url)
        }
        view.showAlert(title: "Unable to proceed", text: "Link is corrupted or empry, unable to open link")
    }
    
    func favOnTap() {
        let flag = !news.favorite
        dataProvider.update(news: news, addToFavorite: flag)
        view.updateTabBar(addToFav: flag)
    }
    
    func shareOnTap() {
        if let url = URL(string: news.link) {
            return view.share(url: url)
        }
        view.showAlert(title: "Unable to proceed", text: "Link is corrupted or empry, unable to open link")
    }
}
