//
//  NewsDetailsViewController.swift
//  RssFeedApp
//
//  Created by Dmitry on 17.11.2020.
//

import UIKit
import SDWebImage

class NewsDetailsViewController: UIViewController, StoryboardInit {
    
    var presenter: NewsDetailsPresenterProtocol?
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDescr: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let favNewsItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(favOnTap))
        let shareNewsItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareOnTap))
        let safariItem = UIBarButtonItem(image: UIImage(systemName: "safari"), style: .plain, target: self, action: #selector(safariOnTap))
        navigationItem.rightBarButtonItems = [shareNewsItem, favNewsItem, safariItem]
        presenter?.updateUI()
    }
    
}

extension NewsDetailsViewController: NewsDetailsViewProtocol {
    func updateUI(imageUrl: String, title: String, descr: String) {
        newsImage.sd_setImage(with: URL(string: imageUrl), completed: nil)
        newsTitle.text = title
        newsDescr.text = descr
    }
    
    @objc func shareOnTap() {
        
    }
    
    @objc func favOnTap() {
        
    }
    
    @objc func safariOnTap() {
        presenter?.safariOnTap()
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
}
