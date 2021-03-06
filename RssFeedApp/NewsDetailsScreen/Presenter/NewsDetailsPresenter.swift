//
//  Presenter.swift
//  RssFeedApp
//
//  Created by Dmitry on 12.12.2020.
//

import Foundation

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
        dataProvider.update(news: self.news, property: .read, value: true)
    }
    
    func updateUI() {
        view.updateUI(imageUrl: news.imageUrl, title: news.title, descr: news.newsDescription, favorite: news.favorite)
    }
    
    func safariOnTap() {
        if let url = URL(string: news.link) {
            return view.openSafari(url: url)
        }
        view.showAlert(title: R.string.localizable.linkValidationTitle(), text: R.string.localizable.linkValidationMsg())
    }
    
    func favOnTap() {
        dataProvider.update(news: news, property: .favorite, value: !news.favorite)
        view.updateTabBar(addToFav: news.favorite)
    }
    
    func shareOnTap() {
        if let url = URL(string: news.link) {
            return view.share(url: url)
        }
        view.showAlert(title: R.string.localizable.linkValidationTitle(), text: R.string.localizable.linkValidationMsg())
    }
}
