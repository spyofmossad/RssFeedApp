//
//  FeedsPresenterTests.swift
//  RssFeedAppTests
//
//  Created by Dmitry on 16.02.2021.
//

import XCTest
@testable import RssFeedApp

class FeedsPresenterTests: XCTestCase {
    
    var sut: FeedsPresenterProtocol!
    
    var view: FeedsViewMock!
    var coordinator: CoordinatorMock!
    var dataProvider: DataProviderProtocolMock!
    var screenBuilder: ScreenBuilderProtocolMock!
    var networkService: NetworkServiceProtocol!
    var navigationController: UINavigationController!

    override func setUpWithError() throws {
        navigationController = UINavigationController()
        dataProvider = DataProviderProtocolMock()
        networkService = NetworkServiceProtocolMock()
        screenBuilder = ScreenBuilderProtocolMock(dataProvider: dataProvider, networkService: networkService)
        coordinator = CoordinatorMock(naviationController: navigationController, screenBuilder: screenBuilder)
        view = FeedsViewMock()
        
        sut = FeedsPresenter(dataProvider: dataProvider, coordinator: coordinator, view: view)
    }

    override func tearDownWithError() throws {
        view = nil
        sut = nil
        coordinator = nil
        dataProvider = nil
        screenBuilder = nil
        networkService = nil
        navigationController = nil
    }
    
    func testNumberOfSections() throws {
        //Arrange
        dataProvider.foldersListArray = [Folder(), Folder()]
        
        //Act
        let numberOfSections = sut.numberOfSections
        
        //Assert
        XCTAssertTrue(numberOfSections == 2)
    }

    func testUpdateUIIfFolderExists() throws {
        //Arrange
        let folder = Folder()
        folder.name = "Test Folder"
        dataProvider.foldersListArray.append(folder)
        
        //Act
        sut.updateUI()
        
        //Assert
        XCTAssertTrue(view.isUpdateUIInvoked)
    }
    
    func testUpdateUIIfFeedExists() throws {
        //Arrange
        dataProvider.feedsCount = 1
        
        //Act
        sut.updateUI()
        
        //Assert
        XCTAssertTrue(view.isUpdateUIInvoked)
    }
    
    func testUpdateUIIfNoDataProvided() throws {
        //Arrange
        dataProvider.feedsCount = 0
        
        //Act
        sut.updateUI()
        
        //Assert
        XCTAssertTrue(view.isShowPlaceholderInvoked)
        XCTAssertTrue(view.showPlaceholderPassedParameter == R.string.localizable.noFeedsPlaceholder())
    }
    
    func testOnTapAddFeed() throws {
        //Act
        sut.onTapAddFeed()
        
        //Assert
        XCTAssertTrue(coordinator.goToAddEditFeedScreenFeedCalled == true)
        XCTAssertNil(coordinator.goToAddEditFeedScreenFeedReceivedFeed)
    }
    
    func testOnTapEditFeed() throws {
        //Arrange
        let index = IndexPath(row: 0, section: 0)
        
        let folder = Folder()
        let feed = Feed()
        folder.feeds.append(feed)
        
        let folder1 = Folder()
        let feed1 = Feed()
        folder1.feeds.append(feed1)
        
        dataProvider.foldersListArray.append(folder)
        dataProvider.foldersListArray.append(folder1)
        
        //Act
        sut.onTapEditFeed(at: index)
        
        //Assert
        XCTAssertTrue(coordinator.goToAddEditFeedScreenFeedCalled == true)
        XCTAssertTrue(coordinator.goToAddEditFeedScreenFeedReceivedFeed == folder.feeds.first)
    }
    
    func testOnTapDelete() throws {
        //Arrange
        let index = IndexPath(row: 0, section: 1)
        
        let folder = Folder()
        let feed = Feed()
        folder.feeds.append(feed)
        
        let folder1 = Folder()
        let feed1 = Feed()
        folder1.feeds.append(feed1)
        
        dataProvider.foldersListArray.append(folder)
        dataProvider.foldersListArray.append(folder1)
        
        //Act
        sut.onTapDelete(at: index)
        
        //Assert
        XCTAssertTrue(dataProvider.deleteEntityCalled == true)
        XCTAssertTrue(dataProvider.deleteEntityCallsCount == 1)
        XCTAssertTrue(dataProvider.deleteEntityReceivedEntity == feed1)
    }
    
    func testOnTapAddFolder() throws {
        //Act
        sut.onTapAddFolder()
        
        //Assert
        XCTAssertTrue(coordinator.goToAddEditFolderScreenFolderCalled == true)
        XCTAssertNil(coordinator.goToAddEditFolderScreenFolderReceivedFolder)
    }
    
    func testOnTapEditFolder() throws {
        //Arrange
        let folder = Folder()
        let folder1 = Folder()
        
        dataProvider.foldersListArray.append(folder)
        dataProvider.foldersListArray.append(folder1)
        
        //Act
        sut.onTapEditFolder(section: 1)
        
        //Assert
        XCTAssertTrue(coordinator.goToAddEditFolderScreenFolderCalled == true)
        XCTAssertTrue(coordinator.goToAddEditFolderScreenFolderReceivedFolder == folder1)
    }
    
    func testTitleForHeaderInSection() throws {
        //Arrange
        let folder = Folder()
        folder.name = "Test"
        let folder1 = Folder()
        folder1.name = "Test1"
        
        dataProvider.foldersListArray.append(folder)
        dataProvider.foldersListArray.append(folder1)
        
        //Act
        let actualTitle = sut.titleForHeaderInSection(1)
        
        //Assert
        XCTAssert(actualTitle == folder1.name)
    }
    
    func testNumberOfRowsInSection() throws {
        //Arrange
        let folder = Folder()
        folder.feeds.append(objectsIn: [Feed(), Feed(), Feed()])
        
        let folder1 = Folder()
        folder1.feeds.append(objectsIn: [Feed(), Feed()])
        
        dataProvider.foldersListArray.append(folder)
        dataProvider.foldersListArray.append(folder1)
        
        //Act
        let actualNumberOfRows = sut.numberOfRowsInSection(0)
        
        //Assert
        XCTAssertTrue(actualNumberOfRows == folder.feeds.count)
    }
    
    func testIndexPaths() throws {
        //Arrange
        let expectedIndexPaths = [
            IndexPath(row: 0, section: 1),
            IndexPath(row: 1, section: 1)
        ]
        
        let folder = Folder()
        folder.feeds.append(objectsIn: [Feed(), Feed(), Feed()])
        
        let folder1 = Folder()
        folder1.feeds.append(objectsIn: [Feed(), Feed()])
        
        dataProvider.foldersListArray.append(folder)
        dataProvider.foldersListArray.append(folder1)
        
        //Act
        let actualIndexPaths = sut.indexPaths(for: 1)
        
        //Assert
        XCTAssertTrue(actualIndexPaths == expectedIndexPaths)
    }
    
    func testHeaderPresenter() throws {
        
    }
    
    func testHeaderOnTap() throws {
        //Arrange
        let section = 10
        
        //Act
        sut.headerOnTap(section: section)
        
        //Assert
        XCTAssertTrue(view.isExpandCollapseInvoked)
        XCTAssertTrue(view.expandCollapsePassedParameter == section)
    }
    
    func testHeightForHeaderInDefaultFolderSection() throws {
        //Arrange
        let section = 0
        let folder = Folder()
        folder.name = Constants.defaultFolder
        dataProvider.foldersListArray.append(folder)
        
        //Act
        let actualHeight = sut.heightForHeaderInSection(section: section)
        
        //Assert
        XCTAssertTrue(actualHeight == 0)
    }
    
    func testHeightForHeaderInCustomFolderSection() throws {
        //Arrange
        let section = 0
        let folder = Folder()
        folder.name = "Custom folder"
        dataProvider.foldersListArray.append(folder)
        
        //Act
        let actualHeight = sut.heightForHeaderInSection(section: section)
        
        //Assert
        XCTAssertTrue(actualHeight == 44)
    }
    
    func testDidSelectRowAt() throws {
        //Arrange
        let index = IndexPath(item: 0, section: 1)
        
        let folder = Folder()
        let feed = Feed()
        folder.feeds.append(feed)
        
        let folder1 = Folder()
        let feed1 = Feed()
        folder1.feeds.append(feed1)
        
        dataProvider.foldersListArray.append(folder)
        dataProvider.foldersListArray.append(folder1)
        
        //Act
        sut.didSelectRowAt(indexPath: index)
        
        //Assert
        XCTAssertTrue(coordinator.goToNewsScrenFeedCalled == true)
        XCTAssert(coordinator.goToNewsScrenFeedReceivedFeed == folder1.feeds.first)
    }
    
    func testCellTitleAt() throws {
        //Arrange
        let index = IndexPath(row: 0, section: 0)
        let folder = Folder()
        let feed = Feed()
        feed.title = "Test feed"
        folder.feeds.append(feed)
        dataProvider.foldersListArray.append(folder)
        
        //Act
        let actualTitle = sut.cellTitleAt(indexPath: index)
        
        //Assert
        XCTAssertTrue(actualTitle == feed.title)
    }
    
    func testCellCategoryAt() throws {
        //Arrange
        let index = IndexPath(row: 0, section: 0)
        let feed = Feed()
        feed.categories.append(objectsIn: ["One", "Two", "Some"])
        let folder = Folder()
        folder.feeds.append(feed)
        dataProvider.foldersListArray.append(folder)
        
        //Act
        let actualCaregory = sut.cellCategoryAt(indexPath: index)
        
        //Assert
        XCTAssertTrue(actualCaregory == "One, Two, Some")
    }
    
    func testCellNewsCountAt() throws {
        //Arrange
        let index = IndexPath(row: 0, section: 0)
        let folder = Folder()
        let feed = Feed()
        feed.news.append(objectsIn: [News(), News(), News(), News()])
        feed.news.first?.read = true
        
        folder.feeds.append(feed)
        dataProvider.foldersListArray.append(folder)
        
        //Act
        let actualCount = sut.cellNewsCountAt(indexPath: index)
        
        //Assert
        XCTAssertTrue(Int(actualCount) == feed.news.count - 1)
    }
}

extension FeedsPresenterTests {
    class FeedsViewMock: FeedsViewProtocol {
        var isUpdateUIInvoked: Bool!
        func updateUI() {
            isUpdateUIInvoked = true
        }
        
        var isShowPlaceholderInvoked: Bool!
        var showPlaceholderPassedParameter: String!
        func showPlaceholder(with text: String) {
            isShowPlaceholderInvoked = true
            showPlaceholderPassedParameter = text
        }
        
        var isExpandCollapseInvoked: Bool!
        var expandCollapsePassedParameter: Int!
        func expandCollapse(_ section: Int) {
            isExpandCollapseInvoked = true
            expandCollapsePassedParameter = section
        }
    }
}
