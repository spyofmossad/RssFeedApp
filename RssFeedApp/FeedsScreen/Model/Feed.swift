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

class RealmRss: Object {
    @objc dynamic var url = ""
    @objc dynamic var title = ""
    var categories = List<String>()
}

class Folder: Object {
    @objc dynamic var name = ""
    var feeds = List<RealmRss>()
}
