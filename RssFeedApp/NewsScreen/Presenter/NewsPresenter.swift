//
//  NewsViewPresenter.swift
//  RssFeedApp
//
//  Created by Dmitry on 09.12.2020.
//

import Foundation

protocol NewsPresenterProtocol {
    var numberOfSections: Int { get }
    init(dataProvider: DataProviderProtocol, networkService: NetworkServiceProtocol, coordinator: Coordinator, view: NewsViewProtocol, feed: Feed)
    
    func updateUI()
    func onRefresh()
    func titleForHeaderInSection(section: Int) -> String
    func numberOfRowsInSection(section: Int) -> Int
    func markAsRead(at indexPath: IndexPath)
    func didSelectRowAt(_ indexPath: IndexPath)
    func swipeActionTitleForRowAt(indexPath: IndexPath) -> String
    func filterOnTap()
    
    func titleAt(_ indexPath: IndexPath) -> String
    func imageUrlAt(_ indexPath: IndexPath) -> String
    func readNewsAt(_ indexPath: IndexPath) -> Bool
}

class NewsPresenter: NewsPresenterProtocol {
    private enum TimePeriod: String {
        case today = "Today"
        case yesterday = "Yesterday"
        case lastWeek = "Last week"
        case older = "Older"
    }
    
    private unowned var view: NewsViewProtocol
    private var dataProvider: DataProviderProtocol
    private var networkService: NetworkServiceProtocol
    private var coordinator: Coordinator
    private var feed: Feed
    private var filteredNews: [News] {
        return feed.news.filter(filterNews)
    }
    
    private var todayNews: [News] {
        return filteredNews.filter { (news) in
            news.date > Date().beginOfDay && news.date < Date()
        }
    }
    private var yesterdayNews: [News] {
        return filteredNews.filter { (news) in
            news.date > Date().yesterday.beginOfDay && news.date < Date().yesterday.endOfDay
        }
    }
    private var lastWeekNews: [News] {
        return filteredNews.filter { (news) in
            news.date > Date().lastWeek.beginOfDay && news.date < Date().yesterday.beginOfDay
        }
    }
    private var olderNews: [News] {
        return filteredNews.filter { (news) in
            news.date < Date().lastWeek.beginOfDay
        }
    }
    private var allNews: [[News]] {
        if feed.filter?.date == true {
            return [filteredNews]
        }
        return [todayNews, yesterdayNews, lastWeekNews, olderNews]
    }
    
    var numberOfSections: Int {
        return allNews.count
    }
        
    required init(dataProvider: DataProviderProtocol, networkService: NetworkServiceProtocol, coordinator: Coordinator, view: NewsViewProtocol, feed: Feed) {
        self.dataProvider = dataProvider
        self.networkService = networkService
        self.coordinator = coordinator
        self.view = view
        self.feed = feed
    }
    
    func updateUI() {
        view.updateUI()
    }
    
    func titleForHeaderInSection(section: Int) -> String {
        if feed.filter?.date == true {
            return DateHelper.shared.toString(from: feed.filter?.dateTime ?? Date())
        }
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
        dataProvider.update(news: news, property: .read, value: !news.read)
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        let selectedNews = allNews[indexPath.section][indexPath.row]
        coordinator.goToNewsDetailsScreen(news: selectedNews)
    }
    
    func swipeActionTitleForRowAt(indexPath: IndexPath) -> String {
        let news = allNews[indexPath.section][indexPath.row]
        return news.read ? R.string.localizable.markAsUnread() : R.string.localizable.markAsRead()
    }
    
    func onRefresh() {
        networkService.fetchData(from: feed.url) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let update):
                    if let update = update {
                        let newNewsCollection = update.news.filter { (updNews) in
                            for news in self.feed.news where news.link == updNews.link {
                                return false
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
    
    func filterOnTap() {
        guard let filter = feed.filter else {
            assertionFailure("Filter entity wasn't initialized")
            return
        }
        coordinator.goToNewsFilterScreen(filter: filter)
    }
    
    func titleAt(_ indexPath: IndexPath) -> String {
        return allNews[indexPath.section][indexPath.row].title
    }
    
    func imageUrlAt(_ indexPath: IndexPath) -> String {
        return allNews[indexPath.section][indexPath.row].imageUrl
    }
    
    func readNewsAt(_ indexPath: IndexPath) -> Bool {
        return allNews[indexPath.section][indexPath.row].read
    }
    
    private func filterNews(news: News) -> Bool {
        if feed.filter?.date == true, let filterDate = feed.filter?.dateTime {
            if !news.date.isBetween(filterDate.beginOfDay, and: filterDate.endOfDay) {
                return false
            }
        }
        
        if feed.filter?.read == true && news.read != feed.filter?.read {
            return false
        }
        
        if feed.filter?.favorite == true && news.favorite != feed.filter?.favorite {
            return false
        }
        
        return true
    }
}
