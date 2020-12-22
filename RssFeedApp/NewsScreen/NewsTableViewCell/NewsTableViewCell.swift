//
//  NewsTableViewCell.swift
//  RssFeedApp
//
//  Created by Dmitry on 09.12.2020.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsDescr: UILabel!
    @IBOutlet weak var unreadMark: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        unreadMark.layer.cornerRadius = unreadMark.bounds.height / 2
    }
    
    func prepare(with title: String, imageUrl: String, read: Bool) {
        let url = URL(string: imageUrl)
        let scale = UIScreen.main.scale
        let thimbnailSize = CGSize(width: 50 * scale, height: 50 * scale)
        self.newsImage.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions(), context: [.imageThumbnailPixelSize: thimbnailSize])
        self.newsDescr.text = title
        self.unreadMark.isHidden = read
    }
}
