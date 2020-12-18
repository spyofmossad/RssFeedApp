//
//  NewsDetailsViewController.swift
//  RssFeedApp
//
//  Created by Dmitry on 17.11.2020.
//

import UIKit
import SDWebImage

class NewsDetailsViewController: UIViewController, StoryboardInit {
    
    var presenter: NewsDetailsPresenterProtocol!
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDescr: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let shareNewsItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareOnTap))
        let safariItem = UIBarButtonItem(image: UIImage(systemName: "safari"), style: .plain, target: self, action: #selector(safariOnTap))
        navigationItem.rightBarButtonItems = [shareNewsItem, safariItem]
        presenter.updateUI()
    }
    
}

extension NewsDetailsViewController: NewsDetailsViewProtocol {
    func updateUI(imageUrl: String, title: String, descr: String, favorite: Bool) {
        newsImage.sd_setImage(with: URL(string: imageUrl), completed: nil)
        newsTitle.text = title
        newsDescr.text = descr
        updateTabBar(addToFav: favorite)
    }
    
    @objc func shareOnTap() {
        presenter.shareOnTap()
    }
    
    @objc func favOnTap() {
        presenter.favOnTap()
    }
    
    @objc func safariOnTap() {
        presenter.safariOnTap()
    }
    
    func openSafari(url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func showAlert(title: String, text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateTabBar(addToFav: Bool) {
        var buttonImage: UIImage?
        if addToFav {
            buttonImage = UIImage(systemName: "star.fill")
        } else {
            buttonImage = UIImage(systemName: "star")
        }
        
        let favNewsItem = UIBarButtonItem(image: buttonImage, style: .plain, target: self, action: #selector(favOnTap))
        if self.navigationItem.rightBarButtonItems?.count ?? 0 > 2 {
            self.navigationItem.rightBarButtonItems?.removeLast()
        }
        self.navigationItem.rightBarButtonItems?.append(favNewsItem)
    }
    
    func share(url: URL) {
        let activityView = UIActivityViewController(activityItems: [url], applicationActivities: [])
        present(activityView, animated: true)
    }
}
