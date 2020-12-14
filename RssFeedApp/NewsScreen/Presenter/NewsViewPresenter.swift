//
//  NewsViewPresenter.swift
//  RssFeedApp
//
//  Created by Dmitry on 09.12.2020.
//

import Foundation

protocol NewsViewProtocol: class {
    func updateUI()
    func onRefresh()
    func endRefresh()
}

protocol NewsViewPresenterProtocol {
    var numberOfSections: Int { get }
    init(dataProvider: DataProviderProtocol, networkService: NetworkServiceProtocol, coordinator: AppCoordinator, view: NewsViewProtocol, feed: RealmRss)
    
    func updateUI()
    func onRefresh()
    func titleForHeaderInSection(section: Int) -> String
    func numberOfRowsInSection(section: Int) -> Int
    func tableViewCellPresenterAt(indexPath: IndexPath, cell: NewsCellViewProtocol) -> NewsCellPresenterProtocol
    func markAsRead(at indexPath: IndexPath)
    func didSelectRowAt(_ indexPath: IndexPath)
    func swipeActionTitleForRowAt(indexPath: IndexPath) -> String
}

class NewsViewPresenter: NewsViewPresenterProtocol {
    private enum TimePeriod: String {
        case today = "Today"
        case yesterday = "Yesterday"
        case lastWeek = "Last week"
        case older = "Older"
    }
    
    private var dataProvider: DataProviderProtocol
    private var networkService: NetworkServiceProtocol
    private var coordinator: AppCoordinator
    private var feed: RealmRss
    private var todayNews: [RealmNews] {
        return feed.news.filter{ (news) in
            news.date! > Date().beginOfDay && news.date! < Date()
        }
    }
    private var yesterdayNews: [RealmNews] {
        return feed.news.filter { (news) in
            news.date! > Date().yesterday.beginOfDay && news.date! < Date().yesterday.endOfDay
        }
    }
    private var lastWeekNews: [RealmNews] {
        return feed.news.filter { (news) in
            news.date! > Date().lastWeek.beginOfDay && news.date! < Date().yesterday.beginOfDay
        }
    }
    private var olderNews: [RealmNews] {
        return feed.news.filter { (news) in
            news.date! < Date().lastWeek.beginOfDay
        }
    }
    private var allNews: [[RealmNews]] {
        return [todayNews, yesterdayNews, lastWeekNews, olderNews]
    }
    
    private unowned var view: NewsViewProtocol
    
    var numberOfRowsInSection: Int {
        return feed.news.count
    }
    
    var numberOfSections: Int {
        return 4
    }
    
    required init(dataProvider: DataProviderProtocol, networkService: NetworkServiceProtocol, coordinator: AppCoordinator, view: NewsViewProtocol, feed: RealmRss) {
        self.dataProvider = dataProvider
        self.networkService = networkService
        self.coordinator = coordinator
        self.view = view
        self.feed = feed
    }
    
    func updateUI() {
        view.updateUI()
    }
    
    func tableViewCellPresenterAt(indexPath: IndexPath, cell: NewsCellViewProtocol) -> NewsCellPresenterProtocol {
        let singleNews = allNews[indexPath.section][indexPath.row]
        return NewsTableViewCellPresenter(news: singleNews)
    }
    
    func titleForHeaderInSection(section: Int) -> String {
        switch section {
        case 0:
            return TimePeriod.today.rawValue
        case 1:
            return TimePeriod.yesterday.rawValue
        case 2:
            return TimePeriod.lastWeek.rawValue
        case 3:
            return TimePeriod.older.rawValue
        default:
            fatalError("No such header specified")
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return allNews[section].count
    }
    
    func markAsRead(at indexPath: IndexPath) {
        let news = allNews[indexPath.section][indexPath.row]
        dataProvider.update(news: news, isRead: !news.isRead)
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        let selectedNews = allNews[indexPath.section][indexPath.row]
        coordinator.goToNewsDetailsScreen(news: selectedNews)
    }
    
    func swipeActionTitleForRowAt(indexPath: IndexPath) -> String {
        let news = allNews[indexPath.section][indexPath.row]
        return news.isRead ? "Mark as unread" : "Mask as read"
    }
    
    func onRefresh() {
        networkService.fetchData(from: feed.url) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let update):
                    if let update = update {
                        let newNewsCollection = update.news.filter { (updNews) in
                            for news in self.feed.news {
                                if news.link == updNews.link {
                                    return false
                                }
                            }
                            return true
                        }
                        self.dataProvider.update(feed: self.feed, with: Array(newNewsCollection))
                        self.view.updateUI()
                        self.view.endRefresh()
                    }
                case .failure(let error):
                    assertionFailure(error.localizedDescription)
                    self.view.endRefresh()
                }
            }
        }
    }
}
