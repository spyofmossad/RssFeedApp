//
//  ViewController.swift
//  RssFeedApp
//
//  Created by Dmitry on 16.11.2020.
//

import UIKit

protocol MainViewDelegate: class {
    func openAddFeed()
    func openAddFolder()
    func openFeedNews()
}

class MainViewController: UIViewController {
    
    weak var delegate: MainViewDelegate?
    
    @IBOutlet weak var feedsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let addEditFeedItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFeed))
        let addEditFolderItem = UIBarButtonItem(image: UIImage(systemName: "folder.badge.plus"), style: .plain, target: self, action: #selector(addFolder))
        navigationItem.rightBarButtonItems = [addEditFeedItem, addEditFolderItem]
    }
    
    @objc private func addFeed() {
        delegate?.openAddFeed()
    }
    
    @objc private func addFolder() {
        delegate?.openAddFolder()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.openFeedNews()
    }
}
