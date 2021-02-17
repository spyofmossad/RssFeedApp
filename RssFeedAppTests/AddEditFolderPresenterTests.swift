//
//  AddEditFolderPresenterTests.swift
//  RssFeedAppTests
//
//  Created by Dmitry on 17.02.2021.
//

import XCTest
@testable import RssFeedApp

class AddEditFolderPresenterTests: XCTestCase {
    
    var sut: AddEditFolderPresenter!
    
    var dataProvider: DataProviderProtocolMock!
    var coordinator: CoordinatorMock!
    var view: AddEditFolderViewMock!
    var navigationController = UINavigationController()
    var screenBuilder: ScreenBuilderProtocolMock!
    var networkService: NetworkServiceProtocolMock!

    override func setUpWithError() throws {
        dataProvider = DataProviderProtocolMock()
        networkService = NetworkServiceProtocolMock()
        screenBuilder = ScreenBuilderProtocolMock(dataProvider: dataProvider, networkService: networkService)
        view = AddEditFolderViewMock()
        coordinator = CoordinatorMock(naviationController: navigationController, screenBuilder: screenBuilder)
    }

    override func tearDownWithError() throws {
        dataProvider = nil
        coordinator = nil
        view = nil
        screenBuilder = nil
        networkService = nil
    }

    func testPresenterInitWithNilFolderAndNoFeeds() throws {
        sut = AddEditFolderPresenter(dataProvider: dataProvider, coordinator: coordinator, view: view, folder: nil)
        XCTAssertTrue(sut.selectedFeeds == [])
        XCTAssertTrue(sut.freeFeedsList == [])
    }
    
    func testPresenterInitWithNilFolderAndExistsFeeds() throws {
        let feed = Feed()
        let folder = Folder()
        folder.name = Constants.defaultFolder
        folder.feeds.append(feed)
        
        dataProvider.foldersListArray.append(folder)
        
        sut = AddEditFolderPresenter(dataProvider: dataProvider, coordinator: coordinator, view: view, folder: nil)
        XCTAssertTrue(sut.selectedFeeds == [])
        XCTAssertTrue(sut.freeFeedsList.count == 1)
        XCTAssertTrue(sut.freeFeedsList.contains(feed))
    }
    
    func testPresenterInitWithExistsFolderAndFeeds() throws {
        let feed = Feed()
        let folder = Folder()
        folder.name = "Test Folder"
        folder.feeds.append(feed)
        dataProvider.foldersListArray.append(folder)
        
        sut = AddEditFolderPresenter(dataProvider: dataProvider, coordinator: coordinator, view: view, folder: folder)
        XCTAssertTrue(sut.selectedFeeds.count == 1)
        XCTAssertTrue(sut.selectedFeeds.contains(feed))
        XCTAssertTrue(sut.freeFeedsList.count == 0)
    }
    
    func testDeleteFolder() throws {
        let folder = Folder()
        folder.name = "Test Folder"
        dataProvider.foldersListArray.append(folder)
        
        sut = AddEditFolderPresenter(dataProvider: dataProvider, coordinator: coordinator, view: view, folder: folder)
        sut.deleteOnTap()
        
        XCTAssertTrue(dataProvider.deleteEntityCalled == true)
        XCTAssertTrue(dataProvider.deleteEntityReceivedEntity == folder)
        XCTAssertTrue(coordinator.popToRootCalled == true)
    }
    
    func testSaveChangesWhenFolderCreated() {
        let defaultFolder = Folder()
        defaultFolder.name = Constants.defaultFolder
        dataProvider.foldersListArray.append(defaultFolder)
        
        sut = AddEditFolderPresenter(dataProvider: dataProvider, coordinator: coordinator, view: view, folder: nil)
        sut.saveChanges()
        
        XCTAssertTrue(dataProvider.saveFolderCalled == true)
        XCTAssertNotNil(dataProvider.saveFolderReceivedFolder)
        XCTAssertTrue(dataProvider.saveFolderReceivedFolder?.name == view.folderTitle)
    }
}

extension AddEditFolderPresenterTests {
    class AddEditFolderViewMock: AddEditFolderView {
        var freeFeedsTableSelectedRows: [IndexPath]?
        
        var selectedFeedsTableSelectedRows: [IndexPath]?
        
        var folderTitle: String? {
            "Test Folder"
        }
        
        func updateUI(with folder: String?) {
            
        }
        
        func deleteOnTap() {
            
        }
        
        func showAlert() {
            
        }
    }
}
