//
//  NewsTableViewCell.swift
//  RssFeedApp
//
//  Created by Dmitry on 09.12.2020.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell, NewsCellViewProtocol {
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsDescr: UILabel!
    @IBOutlet weak var unreadMark: UIView!
    
    var presenter: NewsCellPresenterProtocol? {
        didSet {
            let url = URL(string: presenter?.imageUrl ?? "")
            self.newsImage.sd_setImage(with: url, completed: nil)
            self.newsDescr.text = presenter?.description
            self.unreadMark.isHidden = presenter?.isRead ?? false
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        unreadMark.layer.cornerRadius = unreadMark.bounds.height / 2
    }
}
