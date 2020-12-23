//
//  TableHeaderPresenter.swift
//  RssFeedApp
//
//  Created by Dmitry on 05.12.2020.
//

import Foundation

protocol FeedsTableHeaderPresenterProtocol {
    var headerTitle: String { get }
    
    init(parentPresenter: FeedsPresenterProtocol, section: Int, view: TableViewHeaderCell)
    
    func buttonOnTap()
    func onEditTap()
    func headerInEditMode(yMin: Float, yMax: Float)
    func swipeToDefaultPosition()
}

class TableHeaderPresenter: FeedsTableHeaderPresenterProtocol {
    
    private var section: Int
    private weak var tablePresenter: FeedsPresenterProtocol!
    var view: TableViewHeaderCell
    
    var headerTitle: String {
        return tablePresenter.titleForHeaderInSection(section)
    }
    
    required init(parentPresenter: FeedsPresenterProtocol, section: Int, view: TableViewHeaderCell) {
        self.tablePresenter = parentPresenter
        self.section = section
        self.view = view
    }
    
    func buttonOnTap() {
        tablePresenter.headerOnTap(section: section)
    }
    
    func headerInEditMode(yMin: Float, yMax: Float) {
        tablePresenter.headerInEditMode(yMin, yMax)
    }
    
    func swipeToDefaultPosition() {
        view.swipeWithAnimation(to: .right)
    }
    
    func onEditTap() {
        tablePresenter.onTapEditFolder(section: section)
    }
}
