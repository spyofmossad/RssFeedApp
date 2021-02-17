//
//  ScreenBuilderTests.swift
//  ScreenBuilderTests
//
//  Created by Dmitry on 15.02.2021.
//

import XCTest
import RealmSwift

@testable import RssFeedApp


class ScreenBuilderTests: XCTestCase {
    
    var sut: ScreenBuilderProtocol!
    
    var navigationController = UINavigationController()
    var dataProviderMock: DataProviderProtocol!
    var networkMock: NetworkServiceProtocol!
    var coordinatorMock: Coordinator!

    override func setUpWithError() throws {        
        dataProviderMock = DataProviderMock()
        networkMock = NetworkServiceMock()
        sut = ScreenBuilder(dataProvider: dataProviderMock, networkService: networkMock)
        coordinatorMock = CoordinatorMock(naviationController: navigationController, screenBuilder: sut)
    }

    override func tearDownWithError() throws {
        dataProviderMock = nil
        networkMock = nil
        coordinatorMock = nil
        sut = nil
    }

    func testAddEditFeedViewControllerBuilding() throws {
        let addEditFeedView = sut.addEditFeedView(coordinator: coordinatorMock, feed: nil)
        XCTAssertTrue(addEditFeedView is AddEditFeedViewController)
    }
    
    func testAddEditFolderViewControllerBuilding() throws {
        let addEditFolderView = sut.addEditFolderView(coordinator: coordinatorMock, folder: nil)
        XCTAssertTrue(addEditFolderView is AddEditFolderViewController)
    }
    
    func testFeedsViewControllerBuilding() throws {
        let feedsView = sut.feedsView(coordinator: coordinatorMock)
        XCTAssertTrue(feedsView is FeedsViewController)
    }
    
    func testFeedNewsViewControllerBuilding() throws {
        let newsView = sut.newsView(coordinator: coordinatorMock, feed: Feed())
        XCTAssertTrue(newsView is NewsViewController)
    }
    
    func testNewsDetailsViewControllerBuilding() throws {
        let newsDetailsView = sut.newsDetailsView(coordinator: coordinatorMock, news: News())
        XCTAssertTrue(newsDetailsView is NewsDetailsViewController)
    }
    
    func testNewsFilterViewControllerBuilding() throws {
        let newsFilterView = sut.newsFilterView(coordinator: coordinatorMock, filter: Filter())
        XCTAssertTrue(newsFilterView is NewsFilterViewController)
    }
}

extension ScreenBuilderTests {
    class DataProviderMock: DataProviderProtocol {
        var feedsCount: Int = 0
        
        var foldersListArray: [Folder] = []
        
        func save(folder: Folder) {
            
        }
        
        func save(feed: Feed, to folder: Folder?) {
            
        }
        
        func update(news: News, property: FilterBoolProperties, value: Bool) {
            
        }
        
        func update(feed: Feed, _ url: String?, _ title: String?, _ categories: [String]?) {
            
        }
        
        func update(feed: Feed, with news: [News]) {
            
        }
        
        func update(folder: Folder, title: String) {
            
        }
        
        func update(filter: Filter, property: String, new value: Bool) {
            
        }
        
        func update(filter: Filter, new date: Date) {
            
        }
        
        func delete<T>(entity: T) where T : Object {
            
        }
        
        func move(feed: Feed, from oldFolder: Folder, to newFolder: Folder) {
            
        }
        
        func replace(old feed: Feed, with newFeed: Feed) {
            
        }
    }
    
    class NetworkServiceMock: NetworkServiceProtocol {
        func fetchData(from url: String, completion: @escaping ((Result<Feed?, Error>) -> Void)) {
            
        }
    }
    
    class CoordinatorMock: Coordinator {
        private var navigationController: UINavigationController!
        private var screenBuilder1: ScreenBuilderProtocol!
        
        required init(naviationController: UINavigationController, screenBuilder: ScreenBuilderProtocol) {
            navigationController = naviationController
            screenBuilder1 = screenBuilder
        }
        
        func start() {
        
        }
        
        func goToFeedsView() {
            
        }
        
        func goToAddEditFeedScreen(feed: Feed?) {
            
        }
        
        func goToAddEditFolderScreen(folder: Folder?) {
            
        }
        
        func goToNewsScren(feed: Feed) {
            
        }
        
        func goToNewsFilterScreen(filter: Filter) {
            
        }
        
        func goToNewsDetailsScreen(news: News) {
            
        }
        
        func popViewController() {
            
        }
        
        func popToRoot() {
            
        }
    }
}
