//
//  AddEditFolderPresenter.swift
//  RssFeedApp
//
//  Created by Dmitry on 04.12.2020.
//

import Foundation

protocol AddEditFolderView: class {
    func updateUI()
    func getSelectedRows() -> [IndexPath]?
    func getFolderName() -> String?
}

protocol AddEditFolderProtocol {
    var freeFeedsList: [RealmRss] { get }
    var selectedFeeds: [RealmRss] { get set }
    var folderName: String? { get set }
    
    init(dataProvider: DataProviderProtocol, coordinator: AppCoordinator)
    func saveChanges()
}

class AddEditFolderPresenter: AddEditFolderProtocol {
    private var dataProvider: DataProviderProtocol
    private var coordinator: AppCoordinator
    
    public unowned var view: AddEditFolderView?
    
    var freeFeedsList: [RealmRss] = []
    var selectedFeeds: [RealmRss] = []
    var folderName: String?
    
    required init(dataProvider: DataProviderProtocol, coordinator: AppCoordinator) {
        self.coordinator = coordinator
        self.dataProvider = dataProvider
        if let defaultFolder = dataProvider.foldersList.filter("name = 'Default'").first {
            self.freeFeedsList = Array(defaultFolder.feeds)
        }
    }
    
    func saveChanges() {
        if let folderName = view?.getFolderName(),
           let indexPaths = view?.getSelectedRows() {
            
            let folder = Folder()
            folder.name = folderName
            dataProvider.save(folder: folder)
            indexPaths.forEach { (indexPath) in
                dataProvider.move(feed: freeFeedsList[indexPath.row], to: folder)
            }
            coordinator.popToRoot()
            return
        }
        
        //alert
    }
}
