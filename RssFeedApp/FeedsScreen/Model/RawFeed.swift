//
//  RawFeed.swift
//  RssFeedApp
//
//  Created by Dmitry on 18.12.2020.
//

import Foundation
import XMLCoder


struct RawFeed: Decodable {
    var channel: Channel
}

struct Channel: Decodable {
    var url: String?
    let title: String
    let categories: [String]?
    let news: [RawFeedNews]?
    
    private enum CodingKeys: String, CodingKey {
        case url
        case title
        case categories
        case news = "item"
    }
}

struct RawFeedNews: Decodable {
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
