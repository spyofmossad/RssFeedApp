//
//  DataProvider.swift
//  RssFeedApp
//
//  Created by Dmitry on 18.11.2020.
//

import Foundation
import RealmSwift

protocol DataProviderProtocol {
    var feedsList: Results<Feed> { get }
    var foldersList: Results<Folder> { get }
    
    func save(folder: Folder)
    func save(feed: Feed, to folder: Folder?)
    
    func update(news: News, property: FilterBoolProperties, value: Bool)
    func update(feed: Feed, _ url: String?, _ title: String?, _ categories: [String]?)
    func update(feed: Feed, with news: [News])
    func update(folder: Folder, title: String)
    func update(filter: Filter, property: String, new value: Bool)
    func update(filter: Filter, new date: Date)
    
    func delete<T>(entity: T) where T: Object
    
    func move(feed: Feed, from oldFolder: Folder, to newFolder: Folder)
    func replace(old feed: Feed, with newFeed: Feed)
}

class DataProvider: DataProviderProtocol {    
    private var realm: Realm
    private var defaultFolder: Folder
        
    var feedsList: Results<Feed>
    var foldersList: Results<Folder>
            
    init() {
        realm = try! Realm()
        feedsList = realm.objects(Feed.self)
        foldersList = realm.objects(Folder.self)
        
        if let defaultFolder = foldersList.first(where: {$0.name == Constants.defaultFolder}) {
            self.defaultFolder = defaultFolder
        } else {
            defaultFolder = Folder()
            defaultFolder.name = Constants.defaultFolder
            self.save(folder: defaultFolder)
        }
    }
    
    func save(folder: Folder) {
        write {
            realm.add(folder)
        }
    }
    
    func save(feed: Feed, to folder: Folder?) {
        write {
            if let folder = folder {
                folder.feeds.append(feed)
            } else {
                defaultFolder.feeds.append(feed)
            }
        }
    }
    
    func delete<T>(entity: T) where T: Object {
        switch entity {
        case let feed as Feed:
            self.delete(entities: feed.news)
            if let filter = feed.filter {
                self.delete(entity: filter)
            }
        case let folder as Folder:
            folder.feeds.forEach{ self.delete(entities: $0.news) }
            self.delete(entities: folder.feeds)
        default:
            break
        }
        
        write {
            realm.delete(entity)
        }
    }
    
    func update(news: News, property: FilterBoolProperties, value: Bool) {
        write {
            news[property.rawValue] = value
        }
    }
    
    func update(feed: Feed, _ url: String?, _ title: String?, _ categories: [String]?) {
        write {
            feed.title = title ?? ""
            feed.url = url ?? ""
            if let categories = categories {
                feed.categories.removeAll()
                feed.categories.append(objectsIn: categories)
            }
        }
    }
    
    func update(feed: Feed, with news: [News]) {
        write {
            feed.news.append(objectsIn: news)
        }
    }
    
    func update(folder: Folder, title: String) {
        write {
            folder.name = title
        }
    }
    
    func update(filter: Filter, property: String, new value: Bool) {
        write {
            filter[property] = value
        }
    }
    
    func update(filter: Filter, new date: Date) {
        write {
            filter.dateTime = date
        }
    }
    
    func move(feed: Feed, from oldFolder: Folder, to newFolder: Folder) {
        write {
            guard let index = oldFolder.feeds.index(of: feed) else {
                assertionFailure("No such feed in folder \(oldFolder.name)")
                return
            }
            oldFolder.feeds.remove(at: index)
            newFolder.feeds.append(feed)
        }
    }
    
    func replace(old feed: Feed, with newFeed: Feed) {
        update(feed: feed, newFeed.url, newFeed.title, Array(newFeed.categories))
        delete(entities: feed.news)
        write {
            feed.news.append(objectsIn: newFeed.news)
        }
    }
    
    private func delete<T>(entities: List<T>) where T: Object {
        self.write {
            realm.delete(entities)
        }
    }
    
    private func write(_ completion: () -> Void) {
        do {
            try realm.write{
                completion()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
