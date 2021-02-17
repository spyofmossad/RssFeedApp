//
//  CoordinatorTests.swift
//  RssFeedAppTests
//
//  Created by Dmitry on 15.02.2021.
//

import XCTest
import RealmSwift
@testable import RssFeedApp

class CoordinatorTests: XCTestCase {
    
    private var sut: AppCoordinator!
    
    private var screenBuilder: ScreenBuilderProtocolMock!
    private var dataProviderDummy: DataProviderProtocolMock!
    private var networkServiceDummy: NetworkServiceProtocolMock!
    private var navigationControllerMock: MockNavigationController!

    override func setUpWithError() throws {
        navigationControllerMock = MockNavigationController()
        dataProviderDummy = DataProviderProtocolMock()
        networkServiceDummy = NetworkServiceProtocolMock()
        screenBuilder = ScreenBuilderProtocolMock(dataProvider: dataProviderDummy, networkService: networkServiceDummy)
        
        sut = AppCoordinator(naviationController: navigationControllerMock, screenBuilder: screenBuilder)
        sut.start()
    }

    override func tearDownWithError() throws {
        screenBuilder = nil
        dataProviderDummy = nil
        networkServiceDummy = nil
        navigationControllerMock = nil
    }

    func testCoordinatorStart() throws {
        XCTAssertTrue(navigationControllerMock.setViewControllers == [screenBuilder.feedsViewCoordinatorReturnValue])
    }
    
    func testGoToAddEditFeedScreen() throws {
        sut.goToAddEditFeedScreen(feed: nil)
        XCTAssertTrue(navigationControllerMock.pushedViewController == screenBuilder.addEditFeedViewCoordinatorFeedReturnValue)
        XCTAssertTrue(navigationControllerMock.topViewController == screenBuilder.addEditFeedViewCoordinatorFeedReturnValue)
    }
    
    func testGoToAddEditFolderScreen() throws {
        sut.goToAddEditFolderScreen(folder: nil)
        XCTAssertTrue(navigationControllerMock.pushedViewController == screenBuilder.addEditFolderViewCoordinatorFolderReturnValue)
        XCTAssertTrue(navigationControllerMock.topViewController == screenBuilder.addEditFolderViewCoordinatorFolderReturnValue)
    }
    
    func testGoToNewsScren() throws {
        let feed = Feed()
        sut.goToNewsScren(feed: feed)
        XCTAssertTrue(navigationControllerMock.pushedViewController == screenBuilder.newsViewCoordinatorFeedReturnValue)
        XCTAssertTrue(navigationControllerMock.topViewController == screenBuilder.newsViewCoordinatorFeedReturnValue)
        XCTAssertTrue(screenBuilder.newsViewCoordinatorFeedReceivedArguments?.feed == feed)
    }
    
    func testGoToNewsFilterScreen() throws {
        let filter = Filter()
        sut.goToNewsFilterScreen(filter: filter)
        XCTAssertTrue(navigationControllerMock.pushedViewController == screenBuilder.newsFilterViewCoordinatorFilterReturnValue)
        XCTAssertTrue(navigationControllerMock.topViewController == screenBuilder.newsFilterViewCoordinatorFilterReturnValue)
        XCTAssertTrue(screenBuilder.newsFilterViewCoordinatorFilterReceivedArguments?.filter == filter)
    }
    
    func testGoToNewsDetailsScreen() throws {
        let news = News()
        sut.goToNewsDetailsScreen(news: news)
        XCTAssertTrue(navigationControllerMock.pushedViewController == screenBuilder.newsDetailsViewCoordinatorNewsReturnValue)
        XCTAssertTrue(navigationControllerMock.topViewController == screenBuilder.newsDetailsViewCoordinatorNewsReturnValue)
        XCTAssertTrue(screenBuilder.newsDetailsViewCoordinatorNewsReceivedArguments?.news == news)
    }
    
    func testPopViewController() throws {
        sut.goToNewsScren(feed: Feed())
        sut.goToNewsDetailsScreen(news: News())
        sut.popViewController()
        XCTAssertTrue(navigationControllerMock.isPopViewControllerInvoked)
        XCTAssertTrue(navigationControllerMock.viewControllers.count == 2)
        XCTAssertTrue(navigationControllerMock.topViewController == screenBuilder.newsViewCoordinatorFeedReturnValue)
    }
    
    func testPopToRootViewController() throws {
        sut.goToNewsScren(feed: Feed())
        sut.goToNewsDetailsScreen(news: News())
        sut.popToRoot()
        XCTAssertTrue(navigationControllerMock.isPopToRootViewControllerInvoked)
        XCTAssertTrue(navigationControllerMock.viewControllers.count == 1)
        XCTAssertTrue(navigationControllerMock.topViewController == screenBuilder.feedsViewCoordinatorReturnValue)
    }
}

extension CoordinatorTests {
    class MockNavigationController: UINavigationController {
        var pushedViewController: UIViewController!
        var setViewControllers: [UIViewController]!
        var isPopViewControllerInvoked: Bool!
        var isPopToRootViewControllerInvoked: Bool!
        
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            pushedViewController = viewController
            super.pushViewController(viewController, animated: false)
        }
        
        override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
            setViewControllers = viewControllers
            super.setViewControllers(viewControllers, animated: animated)
        }
        
        override func popViewController(animated: Bool) -> UIViewController? {
            isPopViewControllerInvoked = true
            return super.popViewController(animated: false)
        }
        
        override func popToRootViewController(animated: Bool) -> [UIViewController]? {
            isPopToRootViewControllerInvoked = true
            return super.popToRootViewController(animated: false)
        }
    }
}
