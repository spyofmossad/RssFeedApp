//
//  DataProvider.swift
//  RssFeedApp
//
//  Created by Dmitry on 18.11.2020.
//

import Foundation

protocol DataProviderProtocol {
    func getFeeds(completion: @escaping ([Rss]?) -> Void)
    func saveFeed(feed: Rss)
}

class DataProvider: DataProviderProtocol {
    
    static let shared = DataProvider()
    
    private init() {}
    
    private var feeds: [Rss] = []
    
    func getFeeds(completion: @escaping ([Rss]?) -> Void) {
        completion(feeds)
    }
    
    func saveFeed(feed: Rss) {
        feeds.append(feed)
    }
}
