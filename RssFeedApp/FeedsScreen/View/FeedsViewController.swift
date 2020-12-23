//
//  ViewController.swift
//  RssFeedApp
//
//  Created by Dmitry on 16.11.2020.
//

import UIKit

protocol FeedsViewProtocol: class {
    func updateUI()
    func showPlaceholder(with text: String)
    func expandCollapse(_ section: Int)
}

class FeedsViewController: UIViewController, StoryboardInit {
    
    private var hiddenSections = Set<Int>()
    
    var presenter: FeedsPresenterProtocol!
        
    @IBOutlet weak var feedsTable: UITableView!
    @IBOutlet weak var gestureProxy: GestureProxyView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let addEditFeedItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFeed))
        let addEditFolderItem = UIBarButtonItem(image: UIImage(systemName: "folder.badge.plus"), style: .plain, target: self, action: #selector(addFolder))
        navigationItem.rightBarButtonItems = [addEditFeedItem, addEditFolderItem]
        feedsTable.register(UINib(resource: R.nib.tableViewHeaderCell), forHeaderFooterViewReuseIdentifier: Constants.feedsTableHeader)
        gestureProxy.onTouch = { [weak self] result in
            guard let self = self else { return }
            self.presenter.onTouch(y: result)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.updateUI()
    }
    
    @objc private func addFeed() {
        presenter.onTapAddFeed()
    }
    
    @objc private func addFolder() {
        presenter.onTapAddFolder()
    }
}

extension FeedsViewController: FeedsViewProtocol {
    func updateUI() {
        removePlaceholder()
        feedsTable.reloadData()
    }
    
    func showPlaceholder(with text: String) {
        showPlaceholder(in: self.view, with: text)
    }
    
    func expandCollapse(_ section: Int) {
        let indexPaths = presenter.indexPaths(for: section)
        
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
        return presenter.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(presenter.heightForHeaderInSection(section: section))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if hiddenSections.contains(section) { return 0 }
        return presenter.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = feedsTable.dequeueReusableHeaderFooterView(withIdentifier: Constants.feedsTableHeader) as? TableViewHeaderCell else {
            assertionFailure("Failed to init TableViewHeaderCell")
            return UIView()
        }
        let headerPresenter = presenter.headerPresenter(for: section, view: header)
        header.presenter = headerPresenter
        
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = feedsTable.dequeueReusableCell(withIdentifier: R.reuseIdentifier.feedCell, for: indexPath) else {
            assertionFailure("Failed to init FeedTableViewCell")
            return UITableViewCell()
        }
        cell.prepare(with: presenter.cellTitleAt(indexPath: indexPath),
                     category: presenter.cellCategoryAt(indexPath: indexPath),
                     newsCount: presenter.cellNewsCountAt(indexPath: indexPath))
        
        return cell
    }
}

extension FeedsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: R.string.localizable.deleteLabel()) { (_, _, _) in
            self.feedsTable.beginUpdates()
            self.presenter.onTapDelete(at: indexPath)
            self.feedsTable.deleteRows(at: [indexPath], with: .fade)
            self.feedsTable.endUpdates()
        }
        let edit = UIContextualAction(style: .normal, title: R.string.localizable.editLabel()) { (_, _, _) in
            self.presenter.onTapEditFeed(at: indexPath)
        }
        
        return UISwipeActionsConfiguration(actions: [delete, edit])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(indexPath: indexPath)
    }
}
