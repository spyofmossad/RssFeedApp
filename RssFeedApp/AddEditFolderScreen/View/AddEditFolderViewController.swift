//
//  AddEditViewController.swift
//  RssFeedApp
//
//  Created by Dmitry on 17.11.2020.
//

import UIKit

class AddEditFolderViewController: UIViewController {
    
    private var presenter: AddEditFolderProtocol
    
    @IBOutlet weak var folderName: UITextField!
    @IBOutlet weak var assignedFeedsTable: UITableView!
    @IBOutlet weak var freeFeedsTable: UITableView!
    
    init?(coder: NSCoder, presenter: AddEditFolderProtocol) {
        self.presenter = presenter
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Do not forget to remove entry point")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveChanges))
        assignedFeedsTable.isHidden = true
        updateUI()
    }
    
    override func viewWillLayoutSubviews() {
        [assignedFeedsTable, freeFeedsTable].forEach { (tableView) in
            tableView?.layer.borderColor = UIColor.lightGray.cgColor
            tableView?.layer.borderWidth = 1.0
        }
    }
    
    @objc private func saveChanges() {
        presenter.saveChanges()
    }
}

extension AddEditFolderViewController: AddEditFolderView {
    func getFolderName() -> String? {
        return folderName.text
    }
    
    func getSelectedRows() -> [IndexPath]? {
        return freeFeedsTable.indexPathsForSelectedRows
    }
    
    func updateUI() {
        freeFeedsTable.reloadData()
    }
}

extension AddEditFolderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.freeFeedsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = freeFeedsTable.dequeueReusableCell(withIdentifier: "freeFeed") as! SelectedTableViewCell
        cell.textLabel?.text = presenter.freeFeedsList[indexPath.row].title
        return cell
    }
}
