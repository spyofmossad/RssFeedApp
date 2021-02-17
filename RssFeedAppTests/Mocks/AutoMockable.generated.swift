@testable import RssFeedApp
import RealmSwift
import UIKit

class CoordinatorMock: Coordinator {

    //MARK: - init

    var initNaviationControllerScreenBuilderReceivedArguments: (naviationController: UINavigationController, screenBuilder: ScreenBuilderProtocol)?
    var initNaviationControllerScreenBuilderReceivedInvocations: [(naviationController: UINavigationController, screenBuilder: ScreenBuilderProtocol)] = []
    var initNaviationControllerScreenBuilderClosure: ((UINavigationController, ScreenBuilderProtocol) -> Void)?

    required init(naviationController: UINavigationController, screenBuilder: ScreenBuilderProtocol) {
        initNaviationControllerScreenBuilderReceivedArguments = (naviationController: naviationController, screenBuilder: screenBuilder)
        initNaviationControllerScreenBuilderReceivedInvocations.append((naviationController: naviationController, screenBuilder: screenBuilder))
        initNaviationControllerScreenBuilderClosure?(naviationController, screenBuilder)
    }
    //MARK: - start

    var startCallsCount = 0
    var startCalled: Bool {
        return startCallsCount > 0
    }
    var startClosure: (() -> Void)?

    func start() {
        startCallsCount += 1
        startClosure?()
    }

    //MARK: - goToFeedsView

    var goToFeedsViewCallsCount = 0
    var goToFeedsViewCalled: Bool {
        return goToFeedsViewCallsCount > 0
    }
    var goToFeedsViewClosure: (() -> Void)?

    func goToFeedsView() {
        goToFeedsViewCallsCount += 1
        goToFeedsViewClosure?()
    }

    //MARK: - goToAddEditFeedScreen

    var goToAddEditFeedScreenFeedCallsCount = 0
    var goToAddEditFeedScreenFeedCalled: Bool {
        return goToAddEditFeedScreenFeedCallsCount > 0
    }
    var goToAddEditFeedScreenFeedReceivedFeed: Feed?
    var goToAddEditFeedScreenFeedReceivedInvocations: [Feed?] = []
    var goToAddEditFeedScreenFeedClosure: ((Feed?) -> Void)?

    func goToAddEditFeedScreen(feed: Feed?) {
        goToAddEditFeedScreenFeedCallsCount += 1
        goToAddEditFeedScreenFeedReceivedFeed = feed
        goToAddEditFeedScreenFeedReceivedInvocations.append(feed)
        goToAddEditFeedScreenFeedClosure?(feed)
    }

    //MARK: - goToAddEditFolderScreen

    var goToAddEditFolderScreenFolderCallsCount = 0
    var goToAddEditFolderScreenFolderCalled: Bool {
        return goToAddEditFolderScreenFolderCallsCount > 0
    }
    var goToAddEditFolderScreenFolderReceivedFolder: Folder?
    var goToAddEditFolderScreenFolderReceivedInvocations: [Folder?] = []
    var goToAddEditFolderScreenFolderClosure: ((Folder?) -> Void)?

    func goToAddEditFolderScreen(folder: Folder?) {
        goToAddEditFolderScreenFolderCallsCount += 1
        goToAddEditFolderScreenFolderReceivedFolder = folder
        goToAddEditFolderScreenFolderReceivedInvocations.append(folder)
        goToAddEditFolderScreenFolderClosure?(folder)
    }

    //MARK: - goToNewsScren

    var goToNewsScrenFeedCallsCount = 0
    var goToNewsScrenFeedCalled: Bool {
        return goToNewsScrenFeedCallsCount > 0
    }
    var goToNewsScrenFeedReceivedFeed: Feed?
    var goToNewsScrenFeedReceivedInvocations: [Feed] = []
    var goToNewsScrenFeedClosure: ((Feed) -> Void)?

    func goToNewsScren(feed: Feed) {
        goToNewsScrenFeedCallsCount += 1
        goToNewsScrenFeedReceivedFeed = feed
        goToNewsScrenFeedReceivedInvocations.append(feed)
        goToNewsScrenFeedClosure?(feed)
    }

    //MARK: - goToNewsFilterScreen

    var goToNewsFilterScreenFilterCallsCount = 0
    var goToNewsFilterScreenFilterCalled: Bool {
        return goToNewsFilterScreenFilterCallsCount > 0
    }
    var goToNewsFilterScreenFilterReceivedFilter: Filter?
    var goToNewsFilterScreenFilterReceivedInvocations: [Filter] = []
    var goToNewsFilterScreenFilterClosure: ((Filter) -> Void)?

    func goToNewsFilterScreen(filter: Filter) {
        goToNewsFilterScreenFilterCallsCount += 1
        goToNewsFilterScreenFilterReceivedFilter = filter
        goToNewsFilterScreenFilterReceivedInvocations.append(filter)
        goToNewsFilterScreenFilterClosure?(filter)
    }

    //MARK: - goToNewsDetailsScreen

    var goToNewsDetailsScreenNewsCallsCount = 0
    var goToNewsDetailsScreenNewsCalled: Bool {
        return goToNewsDetailsScreenNewsCallsCount > 0
    }
    var goToNewsDetailsScreenNewsReceivedNews: News?
    var goToNewsDetailsScreenNewsReceivedInvocations: [News] = []
    var goToNewsDetailsScreenNewsClosure: ((News) -> Void)?

    func goToNewsDetailsScreen(news: News) {
        goToNewsDetailsScreenNewsCallsCount += 1
        goToNewsDetailsScreenNewsReceivedNews = news
        goToNewsDetailsScreenNewsReceivedInvocations.append(news)
        goToNewsDetailsScreenNewsClosure?(news)
    }

    //MARK: - popViewController

    var popViewControllerCallsCount = 0
    var popViewControllerCalled: Bool {
        return popViewControllerCallsCount > 0
    }
    var popViewControllerClosure: (() -> Void)?

    func popViewController() {
        popViewControllerCallsCount += 1
        popViewControllerClosure?()
    }

    //MARK: - popToRoot

    var popToRootCallsCount = 0
    var popToRootCalled: Bool {
        return popToRootCallsCount > 0
    }
    var popToRootClosure: (() -> Void)?

    func popToRoot() {
        popToRootCallsCount += 1
        popToRootClosure?()
    }

}
class DataProviderProtocolMock: DataProviderProtocol {
    var feedsCount: Int {
        get { return underlyingFeedsCount }
        set(value) { underlyingFeedsCount = value }
    }
    var underlyingFeedsCount: Int!
    var foldersListArray: [Folder] = []

    //MARK: - save

    var saveFolderCallsCount = 0
    var saveFolderCalled: Bool {
        return saveFolderCallsCount > 0
    }
    var saveFolderReceivedFolder: Folder?
    var saveFolderReceivedInvocations: [Folder] = []
    var saveFolderClosure: ((Folder) -> Void)?

    func save(folder: Folder) {
        saveFolderCallsCount += 1
        saveFolderReceivedFolder = folder
        saveFolderReceivedInvocations.append(folder)
        saveFolderClosure?(folder)
    }

    //MARK: - save

    var saveFeedToCallsCount = 0
    var saveFeedToCalled: Bool {
        return saveFeedToCallsCount > 0
    }
    var saveFeedToReceivedArguments: (feed: Feed, folder: Folder?)?
    var saveFeedToReceivedInvocations: [(feed: Feed, folder: Folder?)] = []
    var saveFeedToClosure: ((Feed, Folder?) -> Void)?

    func save(feed: Feed, to folder: Folder?) {
        saveFeedToCallsCount += 1
        saveFeedToReceivedArguments = (feed: feed, folder: folder)
        saveFeedToReceivedInvocations.append((feed: feed, folder: folder))
        saveFeedToClosure?(feed, folder)
    }

    //MARK: - update

    var updateNewsPropertyValueCallsCount = 0
    var updateNewsPropertyValueCalled: Bool {
        return updateNewsPropertyValueCallsCount > 0
    }
    var updateNewsPropertyValueReceivedArguments: (news: News, property: FilterBoolProperties, value: Bool)?
    var updateNewsPropertyValueReceivedInvocations: [(news: News, property: FilterBoolProperties, value: Bool)] = []
    var updateNewsPropertyValueClosure: ((News, FilterBoolProperties, Bool) -> Void)?

    func update(news: News, property: FilterBoolProperties, value: Bool) {
        updateNewsPropertyValueCallsCount += 1
        updateNewsPropertyValueReceivedArguments = (news: news, property: property, value: value)
        updateNewsPropertyValueReceivedInvocations.append((news: news, property: property, value: value))
        updateNewsPropertyValueClosure?(news, property, value)
    }

    //MARK: - update

    var updateFeedCallsCount = 0
    var updateFeedCalled: Bool {
        return updateFeedCallsCount > 0
    }
    var updateFeedReceivedArguments: (feed: Feed, url: String?, title: String?, categories: [String]?)?
    var updateFeedReceivedInvocations: [(feed: Feed, url: String?, title: String?, categories: [String]?)] = []
    var updateFeedClosure: ((Feed, String?, String?, [String]?) -> Void)?

    func update(feed: Feed, _ url: String?, _ title: String?, _ categories: [String]?) {
        updateFeedCallsCount += 1
        updateFeedReceivedArguments = (feed: feed, url: url, title: title, categories: categories)
        updateFeedReceivedInvocations.append((feed: feed, url: url, title: title, categories: categories))
        updateFeedClosure?(feed, url, title, categories)
    }

    //MARK: - update

    var updateFeedWithCallsCount = 0
    var updateFeedWithCalled: Bool {
        return updateFeedWithCallsCount > 0
    }
    var updateFeedWithReceivedArguments: (feed: Feed, news: [News])?
    var updateFeedWithReceivedInvocations: [(feed: Feed, news: [News])] = []
    var updateFeedWithClosure: ((Feed, [News]) -> Void)?

    func update(feed: Feed, with news: [News]) {
        updateFeedWithCallsCount += 1
        updateFeedWithReceivedArguments = (feed: feed, news: news)
        updateFeedWithReceivedInvocations.append((feed: feed, news: news))
        updateFeedWithClosure?(feed, news)
    }

    //MARK: - update

    var updateFolderTitleCallsCount = 0
    var updateFolderTitleCalled: Bool {
        return updateFolderTitleCallsCount > 0
    }
    var updateFolderTitleReceivedArguments: (folder: Folder, title: String)?
    var updateFolderTitleReceivedInvocations: [(folder: Folder, title: String)] = []
    var updateFolderTitleClosure: ((Folder, String) -> Void)?

    func update(folder: Folder, title: String) {
        updateFolderTitleCallsCount += 1
        updateFolderTitleReceivedArguments = (folder: folder, title: title)
        updateFolderTitleReceivedInvocations.append((folder: folder, title: title))
        updateFolderTitleClosure?(folder, title)
    }

    //MARK: - update

    var updateFilterPropertyNewCallsCount = 0
    var updateFilterPropertyNewCalled: Bool {
        return updateFilterPropertyNewCallsCount > 0
    }
    var updateFilterPropertyNewReceivedArguments: (filter: Filter, property: String, value: Bool)?
    var updateFilterPropertyNewReceivedInvocations: [(filter: Filter, property: String, value: Bool)] = []
    var updateFilterPropertyNewClosure: ((Filter, String, Bool) -> Void)?

    func update(filter: Filter, property: String, new value: Bool) {
        updateFilterPropertyNewCallsCount += 1
        updateFilterPropertyNewReceivedArguments = (filter: filter, property: property, value: value)
        updateFilterPropertyNewReceivedInvocations.append((filter: filter, property: property, value: value))
        updateFilterPropertyNewClosure?(filter, property, value)
    }

    //MARK: - update

    var updateFilterNewCallsCount = 0
    var updateFilterNewCalled: Bool {
        return updateFilterNewCallsCount > 0
    }
    var updateFilterNewReceivedArguments: (filter: Filter, date: Date)?
    var updateFilterNewReceivedInvocations: [(filter: Filter, date: Date)] = []
    var updateFilterNewClosure: ((Filter, Date) -> Void)?

    func update(filter: Filter, new date: Date) {
        updateFilterNewCallsCount += 1
        updateFilterNewReceivedArguments = (filter: filter, date: date)
        updateFilterNewReceivedInvocations.append((filter: filter, date: date))
        updateFilterNewClosure?(filter, date)
    }

    //MARK: - delete<T>

    var deleteEntityCallsCount = 0
    var deleteEntityCalled: Bool {
        return deleteEntityCallsCount > 0
    }
    var deleteEntityReceivedEntity: Object?
    var deleteEntityReceivedInvocations: [Object] = []
    var deleteEntityClosure: ((Object) -> Void)?

    func delete<T: Object>(entity: T) {
        deleteEntityCallsCount += 1
        deleteEntityReceivedEntity = entity
        deleteEntityReceivedInvocations.append(entity)
        deleteEntityClosure?(entity)
    }

    //MARK: - move

    var moveFeedFromToCallsCount = 0
    var moveFeedFromToCalled: Bool {
        return moveFeedFromToCallsCount > 0
    }
    var moveFeedFromToReceivedArguments: (feed: Feed, oldFolder: Folder, newFolder: Folder)?
    var moveFeedFromToReceivedInvocations: [(feed: Feed, oldFolder: Folder, newFolder: Folder)] = []
    var moveFeedFromToClosure: ((Feed, Folder, Folder) -> Void)?

    func move(feed: Feed, from oldFolder: Folder, to newFolder: Folder) {
        moveFeedFromToCallsCount += 1
        moveFeedFromToReceivedArguments = (feed: feed, oldFolder: oldFolder, newFolder: newFolder)
        moveFeedFromToReceivedInvocations.append((feed: feed, oldFolder: oldFolder, newFolder: newFolder))
        moveFeedFromToClosure?(feed, oldFolder, newFolder)
    }

    //MARK: - replace

    var replaceOldWithCallsCount = 0
    var replaceOldWithCalled: Bool {
        return replaceOldWithCallsCount > 0
    }
    var replaceOldWithReceivedArguments: (feed: Feed, newFeed: Feed)?
    var replaceOldWithReceivedInvocations: [(feed: Feed, newFeed: Feed)] = []
    var replaceOldWithClosure: ((Feed, Feed) -> Void)?

    func replace(old feed: Feed, with newFeed: Feed) {
        replaceOldWithCallsCount += 1
        replaceOldWithReceivedArguments = (feed: feed, newFeed: newFeed)
        replaceOldWithReceivedInvocations.append((feed: feed, newFeed: newFeed))
        replaceOldWithClosure?(feed, newFeed)
    }

}
class NetworkServiceProtocolMock: NetworkServiceProtocol {

    //MARK: - fetchData

    var fetchDataFromCompletionCallsCount = 0
    var fetchDataFromCompletionCalled: Bool {
        return fetchDataFromCompletionCallsCount > 0
    }
    var fetchDataFromCompletionReceivedArguments: (url: String, completion: (Result<Feed?, Error>) -> Void)?
    var fetchDataFromCompletionReceivedInvocations: [(url: String, completion: (Result<Feed?, Error>) -> Void)] = []
    var fetchDataFromCompletionClosure: ((String, @escaping ((Result<Feed?, Error>) -> Void)) -> Void)?

    func fetchData(from url: String, completion: @escaping ((Result<Feed?, Error>) -> Void)) {
        fetchDataFromCompletionCallsCount += 1
        fetchDataFromCompletionReceivedArguments = (url: url, completion: completion)
        fetchDataFromCompletionReceivedInvocations.append((url: url, completion: completion))
        fetchDataFromCompletionClosure?(url, completion)
    }

}
class ScreenBuilderProtocolMock: ScreenBuilderProtocol {

    //MARK: - init

    var initDataProviderNetworkServiceReceivedArguments: (dataProvider: DataProviderProtocol, networkService: NetworkServiceProtocol)?
    var initDataProviderNetworkServiceReceivedInvocations: [(dataProvider: DataProviderProtocol, networkService: NetworkServiceProtocol)] = []
    var initDataProviderNetworkServiceClosure: ((DataProviderProtocol, NetworkServiceProtocol) -> Void)?

    required init(dataProvider: DataProviderProtocol, networkService: NetworkServiceProtocol) {
        initDataProviderNetworkServiceReceivedArguments = (dataProvider: dataProvider, networkService: networkService)
        initDataProviderNetworkServiceReceivedInvocations.append((dataProvider: dataProvider, networkService: networkService))
        initDataProviderNetworkServiceClosure?(dataProvider, networkService)
    }
    //MARK: - feedsView

    var feedsViewCoordinatorCallsCount = 0
    var feedsViewCoordinatorCalled: Bool {
        return feedsViewCoordinatorCallsCount > 0
    }
    var feedsViewCoordinatorReceivedCoordinator: Coordinator?
    var feedsViewCoordinatorReceivedInvocations: [Coordinator] = []
    var feedsViewCoordinatorReturnValue: UIViewController!
    var feedsViewCoordinatorClosure: ((Coordinator) -> UIViewController)?

    func feedsView(coordinator: Coordinator) -> UIViewController {
        feedsViewCoordinatorReturnValue = UIViewController()
        feedsViewCoordinatorReturnValue.loadViewIfNeeded()
        feedsViewCoordinatorCallsCount += 1
        feedsViewCoordinatorReceivedCoordinator = coordinator
        feedsViewCoordinatorReceivedInvocations.append(coordinator)
        return feedsViewCoordinatorClosure.map({ $0(coordinator) }) ?? feedsViewCoordinatorReturnValue
    }

    //MARK: - addEditFeedView

    var addEditFeedViewCoordinatorFeedCallsCount = 0
    var addEditFeedViewCoordinatorFeedCalled: Bool {
        return addEditFeedViewCoordinatorFeedCallsCount > 0
    }
    var addEditFeedViewCoordinatorFeedReceivedArguments: (coordinator: Coordinator, feed: Feed?)?
    var addEditFeedViewCoordinatorFeedReceivedInvocations: [(coordinator: Coordinator, feed: Feed?)] = []
    var addEditFeedViewCoordinatorFeedReturnValue: UIViewController!
    var addEditFeedViewCoordinatorFeedClosure: ((Coordinator, Feed?) -> UIViewController)?

    func addEditFeedView(coordinator: Coordinator, feed: Feed?) -> UIViewController {
        addEditFeedViewCoordinatorFeedReturnValue = UIViewController()
        addEditFeedViewCoordinatorFeedReturnValue.loadViewIfNeeded()
        addEditFeedViewCoordinatorFeedCallsCount += 1
        addEditFeedViewCoordinatorFeedReceivedArguments = (coordinator: coordinator, feed: feed)
        addEditFeedViewCoordinatorFeedReceivedInvocations.append((coordinator: coordinator, feed: feed))
        return addEditFeedViewCoordinatorFeedClosure.map({ $0(coordinator, feed) }) ?? addEditFeedViewCoordinatorFeedReturnValue
    }

    //MARK: - addEditFolderView

    var addEditFolderViewCoordinatorFolderCallsCount = 0
    var addEditFolderViewCoordinatorFolderCalled: Bool {
        return addEditFolderViewCoordinatorFolderCallsCount > 0
    }
    var addEditFolderViewCoordinatorFolderReceivedArguments: (coordinator: Coordinator, folder: Folder?)?
    var addEditFolderViewCoordinatorFolderReceivedInvocations: [(coordinator: Coordinator, folder: Folder?)] = []
    var addEditFolderViewCoordinatorFolderReturnValue: UIViewController!
    var addEditFolderViewCoordinatorFolderClosure: ((Coordinator, Folder?) -> UIViewController)?

    func addEditFolderView(coordinator: Coordinator, folder: Folder?) -> UIViewController {
        addEditFolderViewCoordinatorFolderReturnValue = UIViewController()
        addEditFolderViewCoordinatorFolderReturnValue.loadViewIfNeeded()
        addEditFolderViewCoordinatorFolderCallsCount += 1
        addEditFolderViewCoordinatorFolderReceivedArguments = (coordinator: coordinator, folder: folder)
        addEditFolderViewCoordinatorFolderReceivedInvocations.append((coordinator: coordinator, folder: folder))
        return addEditFolderViewCoordinatorFolderClosure.map({ $0(coordinator, folder) }) ?? addEditFolderViewCoordinatorFolderReturnValue
    }

    //MARK: - newsView

    var newsViewCoordinatorFeedCallsCount = 0
    var newsViewCoordinatorFeedCalled: Bool {
        return newsViewCoordinatorFeedCallsCount > 0
    }
    var newsViewCoordinatorFeedReceivedArguments: (coordinator: Coordinator, feed: Feed)?
    var newsViewCoordinatorFeedReceivedInvocations: [(coordinator: Coordinator, feed: Feed)] = []
    var newsViewCoordinatorFeedReturnValue: UIViewController!
    var newsViewCoordinatorFeedClosure: ((Coordinator, Feed) -> UIViewController)?

    func newsView(coordinator: Coordinator, feed: Feed) -> UIViewController {
        newsViewCoordinatorFeedReturnValue = UIViewController()
        newsViewCoordinatorFeedReturnValue.loadViewIfNeeded()
        newsViewCoordinatorFeedCallsCount += 1
        newsViewCoordinatorFeedReceivedArguments = (coordinator: coordinator, feed: feed)
        newsViewCoordinatorFeedReceivedInvocations.append((coordinator: coordinator, feed: feed))
        return newsViewCoordinatorFeedClosure.map({ $0(coordinator, feed) }) ?? newsViewCoordinatorFeedReturnValue
    }

    //MARK: - newsFilterView

    var newsFilterViewCoordinatorFilterCallsCount = 0
    var newsFilterViewCoordinatorFilterCalled: Bool {
        return newsFilterViewCoordinatorFilterCallsCount > 0
    }
    var newsFilterViewCoordinatorFilterReceivedArguments: (coordinator: Coordinator, filter: Filter)?
    var newsFilterViewCoordinatorFilterReceivedInvocations: [(coordinator: Coordinator, filter: Filter)] = []
    var newsFilterViewCoordinatorFilterReturnValue: UIViewController!
    var newsFilterViewCoordinatorFilterClosure: ((Coordinator, Filter) -> UIViewController)?

    func newsFilterView(coordinator: Coordinator, filter: Filter) -> UIViewController {
        newsFilterViewCoordinatorFilterReturnValue = UIViewController()
        newsFilterViewCoordinatorFilterReturnValue.loadViewIfNeeded()
        newsFilterViewCoordinatorFilterCallsCount += 1
        newsFilterViewCoordinatorFilterReceivedArguments = (coordinator: coordinator, filter: filter)
        newsFilterViewCoordinatorFilterReceivedInvocations.append((coordinator: coordinator, filter: filter))
        return newsFilterViewCoordinatorFilterClosure.map({ $0(coordinator, filter) }) ?? newsFilterViewCoordinatorFilterReturnValue
    }

    //MARK: - newsDetailsView

    var newsDetailsViewCoordinatorNewsCallsCount = 0
    var newsDetailsViewCoordinatorNewsCalled: Bool {
        return newsDetailsViewCoordinatorNewsCallsCount > 0
    }
    var newsDetailsViewCoordinatorNewsReceivedArguments: (coordinator: Coordinator, news: News)?
    var newsDetailsViewCoordinatorNewsReceivedInvocations: [(coordinator: Coordinator, news: News)] = []
    var newsDetailsViewCoordinatorNewsReturnValue: UIViewController!
    var newsDetailsViewCoordinatorNewsClosure: ((Coordinator, News) -> UIViewController)?

    func newsDetailsView(coordinator: Coordinator, news: News) -> UIViewController {
        newsDetailsViewCoordinatorNewsReturnValue = UIViewController()
        newsDetailsViewCoordinatorNewsReturnValue.loadViewIfNeeded()
        newsDetailsViewCoordinatorNewsCallsCount += 1
        newsDetailsViewCoordinatorNewsReceivedArguments = (coordinator: coordinator, news: news)
        newsDetailsViewCoordinatorNewsReceivedInvocations.append((coordinator: coordinator, news: news))
        return newsDetailsViewCoordinatorNewsClosure.map({ $0(coordinator, news) }) ?? newsDetailsViewCoordinatorNewsReturnValue
    }

}
