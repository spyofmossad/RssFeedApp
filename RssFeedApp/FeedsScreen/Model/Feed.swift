//
//  Feed.swift
//  RssFeedApp
//
//  Created by Dmitry on 18.11.2020.
//

import Foundation

struct Feed {
    let url: String
    let name: String
    let category: String
}

struct Rss: Decodable {
    var channel: Channel
}

struct Channel: Decodable {
    var url: String?
    let title: String
    let categories: [String]?
}


