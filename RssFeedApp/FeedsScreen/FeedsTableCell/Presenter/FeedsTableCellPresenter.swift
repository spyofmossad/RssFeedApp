//
//  FeedsTableCellPresenter.swift
//  RssFeedApp
//
//  Created by Dmitry on 05.12.2020.
//

import Foundation

protocol FeedsTableCellProtocol {
    
}

protocol FeedsTableCellPresenterProtocol {
    var title: String { get }
    var category: String { get }
    var newsCount: Int { get }
    
    init(feed: Feed)
}

class FeedsTableCellPresenter: FeedsTableCellPresenterProtocol {
    
    private var feed: Feed
    
    required init(feed: Feed) {
        self.feed = feed
    }
    
    var title: String {
        return feed.title
    }
    
    var category: String {
        return feed.categories.joined(separator: ", ")
    }
    
    var newsCount: Int {
        return feed.news.filter({$0.read == false}).count
    }
}
