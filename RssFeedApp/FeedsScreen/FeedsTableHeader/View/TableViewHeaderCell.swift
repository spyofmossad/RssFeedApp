//
//  TableViewHeader.swift
//  RssFeedApp
//
//  Created by Dmitry on 04.12.2020.
//

import UIKit

class TableViewHeaderCell: UITableViewHeaderFooterView, TableHeaderCellProtocol {
    
    private var isExpanded = true
    
    @IBOutlet weak var folderTitle: UILabel!
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    var presenter: FeedsTableHeaderPresenterProtocol! {
        didSet {
            self.folderTitle.text = presenter.headerTitle
            let longTap = UILongPressGestureRecognizer(target: self, action: #selector(onLongTap))
            let shortTap = UITapGestureRecognizer(target: self, action: #selector(onShorTap))
            shortTap.numberOfTapsRequired = 1
            button.addGestureRecognizer(longTap)
            button.addGestureRecognizer(shortTap)
        }
    }
    
    @objc private func onLongTap(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .ended {
            self.presenter.buttonOnLongTap()
        }
    }
    
    @objc private func onShorTap() {
        UIView.animate(withDuration: 0.3) {
            self.arrow.transform = CGAffineTransform(rotationAngle: self.isExpanded ? .pi : (.pi*2))
            self.isExpanded = !self.isExpanded
        }
        self.presenter.buttonOnTap()
    }
}
