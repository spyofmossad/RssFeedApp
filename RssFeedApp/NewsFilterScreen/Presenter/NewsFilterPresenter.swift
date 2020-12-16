//
//  NewsFilterPresenter.swift
//  RssFeedApp
//
//  Created by Dmitry on 14.12.2020.
//

import Foundation

protocol NewsFilterViewProtocol: class {
    func applyOnTap()
}

protocol NewsFilterPresenterProtocol {
    var numberOfRowsInSection: Int { get }
    init(coordinator: AppCoordinator, view: NewsFilterViewProtocol, filter: Filter)
    func applyOnTap()
    func filterLabelAt(indexPath: IndexPath) -> String
    func setOnAt(indexPath: IndexPath) -> Bool
    func viewWillDisappear()
    func didSelectRowAt(indexPath: IndexPath)
}

class NewsFilterPresenter: NewsFilterPresenterProtocol {
    private unowned var view: NewsFilterViewProtocol
    private var coordinator: AppCoordinator
    private var filter: Filter
    
    var numberOfRowsInSection: Int {
        return 3
    }
    
    var filterNames: [String] {
        var labels = [String]()
        let mirror = Mirror(reflecting: filter)
        for child in mirror.children {
            if child.value is Bool {
                labels.append(child.label ?? "")
            }
        }
        return labels
    }
    
    required init(coordinator: AppCoordinator, view: NewsFilterViewProtocol, filter: Filter) {
        self.coordinator = coordinator
        self.view = view
        self.filter = filter
    }
    
    func filterLabelAt(indexPath: IndexPath) -> String {
        return filterNames[indexPath.row].capitalized
    }
    
    func setOnAt(indexPath: IndexPath) -> Bool {
        let propertyName = filterNames[indexPath.row]
        let status = Mirror(reflecting: filter).children.first{ $0.label == propertyName}!.value as! Bool
        return status
    }
    
    func applyOnTap() {
        
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        filter.read = true
    }
    
    func viewWillDisappear() {
        
    }
}
