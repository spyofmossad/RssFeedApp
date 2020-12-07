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
    
    init(feed: RealmRss)
}

class FeedsTableCellPresenter: FeedsTableCellPresenterProtocol {
    
    private var feed: RealmRss
    
    required init(feed: RealmRss) {
        self.feed = feed
    }
    
    var title: String {
        return feed.title
    }
    
    var category: String {
        return feed.categories.joined(separator: ", ")
    }
}
