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
    func deleteFeed(at index: Int)
    func update(old feed: Rss, with newFeed: Rss)
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
    
    func deleteFeed(at index: Int) {
        feeds.remove(at: index)
    }
    
    func update(old feed: Rss, with newFeed: Rss) {
        if let index = feeds.firstIndex(where: {$0.channel.url == feed.channel.url}) {
            feeds.remove(at: index)
            feeds.insert(newFeed, at: index)
        }
    }
}
