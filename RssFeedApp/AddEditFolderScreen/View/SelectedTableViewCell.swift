//
//  SelectedTableViewCell.swift
//  RssFeedApp
//
//  Created by Dmitry on 04.12.2020.
//

import UIKit

class SelectedTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
    }

}
