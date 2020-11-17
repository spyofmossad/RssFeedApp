//
//  AddEditViewController.swift
//  RssFeedApp
//
//  Created by Dmitry on 17.11.2020.
//

import UIKit

class AddEditFolderViewController: UIViewController {
    @IBOutlet weak var folderName: UITextField!
    @IBOutlet weak var assignedFeedsTable: UITableView!
    @IBOutlet weak var freeFeedsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveChanges))
    }
    
    override func viewWillLayoutSubviews() {
        [assignedFeedsTable, freeFeedsTable].forEach { (tableView) in
            tableView?.layer.borderColor = UIColor.lightGray.cgColor
            tableView?.layer.borderWidth = 1.0
        }
    }
    
    @objc private func saveChanges() {}
}
