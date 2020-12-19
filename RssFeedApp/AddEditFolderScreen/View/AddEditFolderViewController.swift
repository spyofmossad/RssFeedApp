//
//  AddEditViewController.swift
//  RssFeedApp
//
//  Created by Dmitry on 17.11.2020.
//

import UIKit

protocol AddEditFolderView: class {
    var freeFeedsTableSelectedRows: [IndexPath]? { get }
    var selectedFeedsTableSelectedRows: [IndexPath]? { get }
    var folderTitle: String? { get }
    
    func updateUI(with folder: String?)
    func deleteOnTap()
    func showAlert()
}

class AddEditFolderViewController: UIViewController, StoryboardInit {
    
    var presenter: AddEditFolderProtocol!
    
    @IBOutlet weak var folderName: UITextField!
    @IBOutlet weak var selectedFeedsTableTitle: UILabel!
    @IBOutlet weak var selectedFeedsTable: UITableView!
    @IBOutlet weak var freeFeedsTable: UITableView!
    @IBOutlet weak var delete: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveChanges))
        delete.addTarget(self, action: #selector(deleteOnTap), for: .touchUpInside)
        presenter.updateUI()
    }
    
    override func viewWillLayoutSubviews() {
        [selectedFeedsTable, freeFeedsTable].forEach { (tableView) in
            tableView?.layer.borderColor = UIColor.lightGray.cgColor
            tableView?.layer.borderWidth = 1.0
        }
    }
    
    @objc private func saveChanges() {
        presenter.saveChanges()
    }
}

extension AddEditFolderViewController: AddEditFolderView {
    var folderTitle: String? {
        return folderName.text
    }
    
    var freeFeedsTableSelectedRows: [IndexPath]? {
        return freeFeedsTable.indexPathsForSelectedRows
    }
    
    var selectedFeedsTableSelectedRows: [IndexPath]? {
        return selectedFeedsTable.indexPathsForSelectedRows
    }
    
    func updateUI(with folder: String?) {
        if let folder = folder {
            self.folderName.text = folder
            selectedFeedsTable.isHidden = false
            selectedFeedsTableTitle.isHidden = false
        } else {
            delete.isHidden = true
            selectedFeedsTable.isHidden = true
            selectedFeedsTableTitle.isHidden = true
        }
        
        freeFeedsTable.reloadData()
        selectedFeedsTable.reloadData()
    }
    
    @objc func deleteOnTap() {
        let alert = UIAlertController(title: R.string.localizable.deleteFolderTitle(), message: R.string.localizable.deleteFolderMsg(), preferredStyle: .alert)
        let alertCancelAction = UIAlertAction(title: R.string.localizable.cancelLabel(), style: .cancel, handler: nil)
        let alertOkAction = UIAlertAction(title: R.string.localizable.deleteLabel(), style: .destructive) { (action) in
            self.presenter.deleteOnTap()
        }
        alert.addAction(alertCancelAction)
        alert.addAction(alertOkAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: R.string.localizable.folderNameValidationTitle(), message: R.string.localizable.folderNameValidationMsg(), preferredStyle: .alert)
        let alertCancelAction = UIAlertAction(title: R.string.localizable.closeLabel(), style: .cancel, handler: nil)
        alert.addAction(alertCancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension AddEditFolderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case freeFeedsTable:
            return presenter!.freeFeedsList.count
        case selectedFeedsTable:
            return presenter!.selectedFeeds.count
        default:
            fatalError("Expected table wasn't found")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case freeFeedsTable:
            let cell = freeFeedsTable.dequeueReusableCell(withIdentifier: "freeFeedCell") as! FeedsTableViewCell
            cell.textLabel?.text = presenter!.freeFeedsList[indexPath.row].title
            return cell
        case selectedFeedsTable:
            let cell = selectedFeedsTable.dequeueReusableCell(withIdentifier: "feedInFolderCell") as! FeedsTableViewCell
            cell.textLabel?.text = presenter!.selectedFeeds[indexPath.row].title
            return cell
        default:
            fatalError("Expected table wasn't found")
        }
    }
}
