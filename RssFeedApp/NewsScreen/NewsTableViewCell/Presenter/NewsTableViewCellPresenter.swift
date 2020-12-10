//
//  NewsTableViewCellPresenter.swift
//  RssFeedApp
//
//  Created by Dmitry on 09.12.2020.
//

import Foundation
import SDWebImage

protocol NewsCellViewProtocol {
}

protocol NewsCellPresenterProtocol {
    var description: String { get }
    var imageUrl: String { get }
    var isRead: Bool { get }
    init (news: RealmNews)
}

class NewsTableViewCellPresenter: NewsCellPresenterProtocol {
    private var news: RealmNews
    
    var description: String {
        return news.title
    }
    
    var imageUrl: String {
        return news.imageUrl
    }
    
    var isRead: Bool {
        return news.isRead
    }
    
    required init(news: RealmNews) {
        self.news = news
    }
}
