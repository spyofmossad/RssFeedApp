//
//  FeedTableViewCell.swift
//  RssFeedApp
//
//  Created by Dmitry on 02.12.2020.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var news: UILabel!
    
    func prepare(with title: String, category: String, newsCount: String) {
        self.title.text = title
        self.category.text = category
        self.news.text = newsCount
    }
}
