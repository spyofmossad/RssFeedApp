//
//  Feed.swift
//  RssFeedApp
//
//  Created by Dmitry on 18.11.2020.
//

import Foundation
import RealmSwift

struct Rss: Decodable {
    var channel: Channel
}

struct Channel: Decodable {
    var url: String?
    let title: String
    let categories: [String]?
}

@objcMembers class RealmRss: Object {
    @objc dynamic var url = ""
    @objc dynamic var title = ""
    var categories = List<String>()
    
    convenience init(feed: Rss) {
        self.init()
        self.url = feed.channel.url ?? ""
        self.title = feed.channel.title
        self.categories.append(objectsIn: feed.channel.categories ?? [String]())
    }
}

class Folder: Object {
    @objc dynamic var name = ""
    var feeds = List<RealmRss>()
}
