//
//  TableHeaderPresenter.swift
//  RssFeedApp
//
//  Created by Dmitry on 05.12.2020.
//

import Foundation

protocol TableHeaderCellProtocol: class {
}

protocol FeedsTableHeaderPresenterProtocol {
    var headerTitle: String { get }
    
    init(parentPresenter: FeedsPresenterProtocol, section: Int)
    
    func buttonOnTap()
    func buttonOnLongTap()
}

class TableHeaderPresenter: FeedsTableHeaderPresenterProtocol {
    
    private var section: Int
    private weak var tablePresenter: FeedsPresenterProtocol!
    
    var headerTitle: String {
        return tablePresenter.titleForHeaderInSection(section)
    }
    
    required init(parentPresenter: FeedsPresenterProtocol, section: Int) {
        self.tablePresenter = parentPresenter
        self.section = section
    }
    
    func buttonOnTap() {
        tablePresenter.headerOnTap(section: section)
    }
    
    func buttonOnLongTap() {
        tablePresenter.headerOnLongTap(section: section)
    }
}
