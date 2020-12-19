//
//  AddEditFolderPresenter.swift
//  RssFeedApp
//
//  Created by Dmitry on 04.12.2020.
//

import Foundation

protocol AddEditFolderProtocol {
    var freeFeedsList: [Feed] { get }
    var selectedFeeds: [Feed] { get }
    var folderName: String? { get set }
    
    init(dataProvider: DataProviderProtocol, coordinator: Coordinator, view: AddEditFolderView, folder: Folder?)
    
    func updateUI()
    func saveChanges()
    func deleteOnTap()
}

class AddEditFolderPresenter: AddEditFolderProtocol {
    private var dataProvider: DataProviderProtocol
    private var coordinator: Coordinator
    private var currentFolder: Folder?
    
    public unowned var view: AddEditFolderView
    
    var freeFeedsList: [Feed] = []
    var selectedFeeds: [Feed] = []
    var folderName: String?
    
    required init(dataProvider: DataProviderProtocol, coordinator: Coordinator, view: AddEditFolderView, folder: Folder?) {
        self.coordinator = coordinator
        self.dataProvider = dataProvider
        self.view = view
        self.currentFolder = folder
        if let currentFolderFeeds = self.currentFolder?.feeds {
            selectedFeeds = Array(currentFolderFeeds)
        }
        if let defaultFolderFeeds = dataProvider.foldersList.first(where: {$0.name == Constants.defaultFolder})?.feeds {
            freeFeedsList = Array(defaultFolderFeeds)
        }
    }
    
    func updateUI() {
        view.updateUI(with: currentFolder?.name)
    }
    
    func saveChanges() {
        guard let defaulfFolder = dataProvider.foldersList.first(where: {$0.name == Constants.defaultFolder}) else {
            assertionFailure("Default folder does'n exists")
            return
        }
        if let folderName = view.folderTitle, !folderName.isEmpty {
            if let currentFolder = self.currentFolder {
                dataProvider.update(folder: currentFolder, title: folderName)
                if let selectedRows = self.view.freeFeedsTableSelectedRows {
                    selectedRows.forEach { (indexPath) in
                        dataProvider.move(feed: freeFeedsList[indexPath.row], from: defaulfFolder, to: currentFolder)
                    }
                }
                if let deselectedRows = self.view.selectedFeedsTableSelectedRows {
                    deselectedRows.forEach { (indexPath) in
                        dataProvider.move(feed: selectedFeeds[indexPath.row], from: currentFolder, to: defaulfFolder)
                    }
                }
            } else {
                let folder = Folder()
                folder.name = folderName
                dataProvider.save(folder: folder)
                if let selectedRows = self.view.freeFeedsTableSelectedRows {
                    selectedRows.forEach { (indexPath) in
                        dataProvider.move(feed: freeFeedsList[indexPath.row], from: defaulfFolder, to: folder)
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
        dataProvider.delete(entity: folder)
        coordinator.popToRoot()
    }
}
