//
//  AddEditFeedViewController.swift
//  RssFeedApp
//
//  Created by Dmitry on 17.11.2020.
//

import UIKit

class AddEditFeedViewController: UIViewController {

    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var categoriesTable: UITableView!
    @IBOutlet weak var save: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        categoriesTable.layer.borderColor = UIColor.lightGray.cgColor
        categoriesTable.layer.borderWidth = 1.0
    }
}
