//
//  FeedTableViewCell.swift
//  RssFeedApp
//
//  Created by Dmitry on 02.12.2020.
//

import UIKit

class FeedTableViewCell: UITableViewCell, FeedsTableCellProtocol {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var news: UILabel!
    
    var presenter: FeedsTableCellPresenterProtocol? {
        didSet {
            self.title.text = self.presenter?.title
            self.category.text = self.presenter?.category
            self.news.text = self.presenter?.newsCount.description
        }
    }

}
