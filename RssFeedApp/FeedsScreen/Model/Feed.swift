//
//  Feed.swift
//  RssFeedApp
//
//  Created by Dmitry on 18.11.2020.
//

import Foundation
import RealmSwift

class Folder: Object {
    @objc dynamic var name = ""
    var feeds = List<Feed>()
}

class Feed: Object {
    @objc dynamic var url = ""
    @objc dynamic var title = ""
    var categories = List<String>()
    var news = List<News>()
    @objc dynamic var filter: Filter?
    
    convenience init(feed: RawFeed) {
        self.init()
        self.url = feed.channel.url ?? ""
        self.title = feed.channel.title
        self.categories.append(objectsIn: feed.channel.categories ?? [String]())
        if let news = feed.channel.news {
            self.news.append(objectsIn: news.map({News(news: $0)}))
        }
        self.filter = Filter()
    }
}

class News: Object {
    @objc dynamic var title = ""
    @objc dynamic var link = ""
    @objc dynamic var newsDescription = ""
    @objc dynamic var imageUrl = ""
    @objc dynamic var date: Date = Date()
    @objc dynamic var read: Bool = false
    @objc dynamic var favorite: Bool = false
    
    convenience init(news: RawFeedNews) {
        self.init()
        self.title = news.title ?? ""
        self.link = news.link ?? ""
        self.imageUrl = news.content?.imageUrl ?? news.thumbnail?.imageUrl ?? ""
        if let description = news.description {
            self.newsDescription = description.trimmedHtml
        }
        if let pubDate = news.pubDate {
            self.date = DateHelper.shared.parse(from: pubDate) ?? Date()
        }
    }
}
