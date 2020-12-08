//
//  AddEditFolderPresenter.swift
//  RssFeedApp
//
//  Created by Dmitry on 04.12.2020.
//

import Foundation

@objc protocol AddEditFolderView: class {
    var freeFeedsTableSelectedRows: [IndexPath]? { get }
    var selectedFeedsTableSelectedRows: [IndexPath]? { get }
    var folderTitle: String? { get }
    
    func updateUI(with folder: String?)
    @objc func deleteOnTap()
    func showAlert()
}

protocol AddEditFolderProtocol {
    var freeFeedsList: [RealmRss] { get }
    var selectedFeeds: [RealmRss] { get }
    var folderName: String? { get set }
    
    init(dataProvider: DataProviderProtocol, coordinator: AppCoordinator, view: AddEditFolderView, folder: Folder?)
    
    func updateUI()
    func saveChanges()
    func deleteOnTap()
}

class AddEditFolderPresenter: AddEditFolderProtocol {
    private var dataProvider: DataProviderProtocol
    private var coordinator: AppCoordinator
    private var currentFolder: Folder?
    
    public unowned var view: AddEditFolderView
    
    var freeFeedsList: [RealmRss] = []
    var selectedFeeds: [RealmRss] = []
    var folderName: String?
    
    required init(dataProvider: DataProviderProtocol, coordinator: AppCoordinator, view: AddEditFolderView, folder: Folder?) {
        self.coordinator = coordinator
        self.dataProvider = dataProvider
        self.view = view
        self.currentFolder = folder
        if let currentFolderFeeds = self.currentFolder?.feeds {
            selectedFeeds = Array(currentFolderFeeds)
        }
        if let defaultFolderFeeds = dataProvider.foldersList.filter("name = 'Default'").first?.feeds {
            freeFeedsList = Array(defaultFolderFeeds)
        }
    }
    
    func updateUI() {
        view.updateUI(with: currentFolder?.name)
    }
    
    func saveChanges() {
        if let folderName = view.folderTitle, !folderName.isEmpty {
            
            if let currentFolder = self.currentFolder {
                dataProvider.update(folder: currentFolder, title: folderName)
                if let selectedRows = self.view.freeFeedsTableSelectedRows {
                    selectedRows.forEach { (indexPath) in
                        dataProvider.move(feed: freeFeedsList[indexPath.row], to: currentFolder)
                    }
                }
                if let deselectedRows = self.view.selectedFeedsTableSelectedRows {
                    deselectedRows.forEach { (indexPath) in
                        dataProvider.moveToDefault(feed: selectedFeeds[indexPath.row], from: currentFolder)
                    }
                }
            } else {
                let folder = Folder()
                folder.name = folderName
                dataProvider.save(folder: folder)
                if let selectedRows = self.view.freeFeedsTableSelectedRows {
                    selectedRows.forEach { (indexPath) in
                        dataProvider.move(feed: freeFeedsList[indexPath.row], to: folder)
                    }
                }
            }
            
            coordinator.popToRoot()
            return
        }
        
        self.view.showAlert()
    }
    
    func deleteOnTap() {
        guard let folder = currentFolder else {
            assertionFailure("Trying to delete nil? folder")
            return
        }
        dataProvider.delete(folder: folder)
        coordinator.popToRoot()
    }
}
