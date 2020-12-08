//
//  ViewController.swift
//  RssFeedApp
//
//  Created by Dmitry on 16.11.2020.
//

import UIKit

class FeedsViewController: UIViewController, StoryboardInit {
    
    private var hiddenSections = Set<Int>()
    
    var presenter: FeedsPresenterProtocol?
        
    @IBOutlet weak var feedsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let addEditFeedItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFeed))
        let addEditFolderItem = UIBarButtonItem(image: UIImage(systemName: "folder.badge.plus"), style: .plain, target: self, action: #selector(addFolder))
        navigationItem.rightBarButtonItems = [addEditFeedItem, addEditFolderItem]
        let nib = UINib(nibName: "TableViewHeaderCell", bundle: nil)
        feedsTable.register(nib, forHeaderFooterViewReuseIdentifier: "customHeader")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        feedsTable.reloadData()
    }
    
    @objc private func addFeed() {
        presenter?.onTapAddFeed()
    }
    
    @objc private func addFolder() {
        presenter?.onTapAddFolder()
    }
}

extension FeedsViewController: FeedsViewProtocol {
    func expandCollapse(_ section: Int) {
        guard let indexPaths = presenter?.indexPaths(for: section) else { return }
        
        if self.hiddenSections.contains(section) {
            self.hiddenSections.remove(section)
            self.feedsTable.insertRows(at: indexPaths, with: .fade)
        } else {
            self.hiddenSections.insert(section)
            self.feedsTable.deleteRows(at: indexPaths, with: .fade)
        }
    }

}

extension FeedsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(presenter?.heightForHeaderInSection(section: section) ?? 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if hiddenSections.contains(section) { return 0 }
        return presenter?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = feedsTable.dequeueReusableHeaderFooterView(withIdentifier: "customHeader") as? TableViewHeaderCell
        let headerPresenter = presenter?.headerPresenter(for: section)
        
        guard let header = headerView else {
            assertionFailure("Failed to init TableViewHeaderCell")
            return UIView()
        }
        
        header.presenter = headerPresenter
        
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = feedsTable.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as? FeedTableViewCell
        let cellPresenter = presenter?.cellPresenter(for: indexPath)
        
        guard let tableCell = cell else {
            assertionFailure("Failed to init FeedTableViewCell")
            return UITableViewCell()
        }
        
        tableCell.presenter = cellPresenter
        
        return tableCell
    }
}

extension FeedsViewController: UITableViewDelegate {
    private func delete(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            self.feedsTable.beginUpdates()
            self.presenter?.onTapDelete(at: indexPath)
            self.feedsTable.deleteRows(at: [indexPath], with: .fade)
            self.feedsTable.endUpdates()
        }
        
        return action
    }
    
    private func edit(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Edit") { (_, _, _) in
            self.presenter?.onTapEditFeed(at: indexPath)
        }
        
        return action
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = self.delete(at: indexPath)
        let edit = self.edit(at: indexPath)
        let swipe = UISwipeActionsConfiguration(actions: [delete, edit])
        
        return swipe
    }
}
