//
//  Feed.swift
//  RssFeedApp
//
//  Created by Dmitry on 18.11.2020.
//

import Foundation
import XMLCoder
import RealmSwift

struct Rss: Decodable {
    var channel: Channel
}

struct Channel: Decodable {
    var url: String?
    let title: String
    let categories: [String]?
    let news: [News]?
    
    private enum CodingKeys: String, CodingKey {
        case url
        case title
        case categories
        case news = "item"
    }
}

struct News: Decodable {
    let title: String?
    let link: String?
    let description: String?
    let content: Content?
    let pubDate: String?
}

struct Content: Decodable, DynamicNodeEncoding {
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "url"
    }
    
    static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        switch key {
        case CodingKeys.imageUrl:
            return .attribute
        default:
            return .element
        }
    }
}


class Folder: Object {
    @objc dynamic var name = ""
    var feeds = List<RealmRss>()
}

class RealmRss: Object {
    @objc dynamic var url = ""
    @objc dynamic var title = ""
    var categories = List<String>()
    var news = List<RealmNews>()
    @objc dynamic var filter: Filter?
    
    convenience init(feed: Rss) {
        self.init()
        self.url = feed.channel.url ?? ""
        self.title = feed.channel.title
        self.categories.append(objectsIn: feed.channel.categories ?? [String]())
        if let news = feed.channel.news {
            self.news.append(objectsIn: news.map({RealmNews(news: $0)}))
        }
        self.filter = Filter()
    }
}

class RealmNews: Object {
    @objc dynamic var title = ""
    @objc dynamic var link = ""
    @objc dynamic var newsDescription = ""
    @objc dynamic var imageUrl = ""
    @objc dynamic var date: Date? = nil
    @objc dynamic var isRead: Bool = false
    @objc dynamic var favorite: Bool = false
    
    convenience init(news: News) {
        self.init()
        self.title = news.title ?? ""
        self.link = news.link ?? ""
        self.newsDescription = news.description ?? ""
        self.imageUrl = news.content?.imageUrl ?? ""
        if let pubDate = news.pubDate {
            self.date = DateHelper.shared.parse(from: pubDate)
        }
    }
}
