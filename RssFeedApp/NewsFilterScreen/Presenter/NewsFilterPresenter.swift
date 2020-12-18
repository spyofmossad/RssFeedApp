//
//  NewsFilterPresenter.swift
//  RssFeedApp
//
//  Created by Dmitry on 14.12.2020.
//

import Foundation

protocol NewsFilterPresenterProtocol {
    var date: Date { get }
    var numberOfRowsInSection: Int { get }
    
    init(coordinator: AppCoordinator, dataProvider: DataProviderProtocol,  view: NewsFilterViewProtocol, filter: Filter)
    
    func applyOnTap()
    func resetOnTap()
    func filterLabelAt(indexPath: IndexPath) -> String
    func setOnAt(indexPath: IndexPath) -> Bool
    func didSelectRowAt(indexPath: IndexPath)
}

class NewsFilterPresenter: NewsFilterPresenterProtocol {
    
    private unowned var view: NewsFilterViewProtocol
    private var dataProvider: DataProviderProtocol
    private var coordinator: AppCoordinator
    private var filter: Filter
    
    var date: Date {
        return filter.dateTime
    }
    
    var filterNames: [String] {
        return filter.objectSchema.properties.compactMap { (property) in
            if property.type == .bool {
                return property.name
            }
            return nil
        }
    }
    
    var numberOfRowsInSection: Int {
        return filterNames.count
    }
    
    required init(coordinator: AppCoordinator, dataProvider: DataProviderProtocol, view: NewsFilterViewProtocol, filter: Filter) {
        self.coordinator = coordinator
        self.dataProvider = dataProvider
        self.view = view
        self.filter = filter
    }
    
    func filterLabelAt(indexPath: IndexPath) -> String {
        return filterNames[indexPath.row].capitalized
    }
    
    func setOnAt(indexPath: IndexPath) -> Bool {
        let property = filterNames[indexPath.row]
        let status = filter[property] as? Bool
        return status ?? false
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        let name = filterNames[indexPath.row]
        if let value = filter[name] as? Bool {
            dataProvider.update(filter: filter, property: name, new: !value)
        }
    }
    
    func applyOnTap() {
        dataProvider.update(filter: filter, new: view.dateTime)
        coordinator.popViewController()
    }
    
    func resetOnTap() {
        filterNames.forEach { (name) in
            dataProvider.update(filter: filter, property: name, new: false)
        }
        coordinator.popViewController()
    }
}
