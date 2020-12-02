//
//  ViewController.swift
//  RssFeedApp
//
//  Created by Dmitry on 16.11.2020.
//

import UIKit

class FeedsViewController: UIViewController {
        
    private var presenter: FeedsPresenterProtocol
        
    @IBOutlet weak var feedsTable: UITableView!
    
    init?(coder: NSCoder, presenter: FeedsPresenterProtocol) {
        self.presenter = presenter
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Do not forget to remove entry point")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let addEditFeedItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFeed))
        let addEditFolderItem = UIBarButtonItem(image: UIImage(systemName: "folder.badge.plus"), style: .plain, target: self, action: #selector(addFolder))
        navigationItem.rightBarButtonItems = [addEditFeedItem, addEditFolderItem]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getFeeds()
    }
    
    @objc private func addFeed() {
        presenter.onTapAddFeed()
    }
    
    @objc private func addFolder() {
    }
}

extension FeedsViewController: FeedsViewProtocol {
    func updateView() {
        feedsTable.reloadData()
    }
}

extension FeedsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getFeedsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = feedsTable.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as? FeedTableViewCell
        cell?.title.text = presenter.getTitle(indexPath: indexPath)
        cell?.category.text = presenter.getCategories(indexPath: indexPath)
        
        return cell!
    }
}

extension FeedsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
