//
//  NewsViewController.swift
//  RssFeedApp
//
//  Created by Dmitry on 17.11.2020.
//

import UIKit

class NewsViewController: UIViewController, StoryboardInit {
    
    var presenter: NewsViewPresenterProtocol?
    
    @IBOutlet weak var newsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        newsTable.register(nib, forCellReuseIdentifier: "newsCell")
        presenter?.updateUI()
    }
}

extension NewsViewController: NewsViewProtocol {
    func updateUI() {
        newsTable.reloadData()
    }
}

extension NewsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter?.titleForHeaderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell
        guard let tableCell = cell else {
            assertionFailure("Unable to init NewsTableViewCell")
            return UITableViewCell()
        }
        
        let cellPresenter = presenter?.tableViewCellPresenterAt(indexPath: indexPath, cell: tableCell)
        tableCell.presenter = cellPresenter
        
        return cell!
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let markAsRead = UIContextualAction(style: .normal, title: "Mark as Read") { (_, _, completion) in
            self.presenter?.markAsRead(at: indexPath)
            self.newsTable.reloadRows(at: [indexPath], with: .automatic)
            completion(true)
        }

        return UISwipeActionsConfiguration(actions: [markAsRead])
    }
}
