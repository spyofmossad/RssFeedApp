//
//  TableViewHeader.swift
//  RssFeedApp
//
//  Created by Dmitry on 04.12.2020.
//

import UIKit

class TableViewHeaderCell: UITableViewHeaderFooterView, TableHeaderView {
    
    @IBOutlet weak var folderTitle: UILabel!
    @IBOutlet weak var arrow: UIImageView!
    @IBAction func arrowButton(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.arrow.transform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
        }
        self.presenter?.buttonOnTap(section: 0)
    }
    
    var presenter: TableHeaderPresenterProtocol? {
    }
}
