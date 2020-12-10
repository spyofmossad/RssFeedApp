//
//  DataProvider.swift
//  RssFeedApp
//
//  Created by Dmitry on 18.11.2020.
//

import Foundation
import RealmSwift

protocol DataProviderProtocol {
    var feedsList: Results<RealmRss> { get }
    var foldersList: Results<Folder> { get }
    
    func save(folder: Folder)
    func save(feed: RealmRss, to folder: Folder?)
    func delete(news: RealmNews)
    func delete(feed: RealmRss)
    func delete(folder: Folder)
    func update(news: RealmNews, isRead: Bool)
    func update(feed: RealmRss, new url: String?, new title: String?, new categories: [String]?)
    func update(folder: Folder, title: String)
    func move(feed: RealmRss, to folder: Folder)
    func moveToDefault(feed: RealmRss, from folder: Folder)
}

class DataProvider: DataProviderProtocol {
    private var realm: Realm
    private var defaultFolder: Folder
        
    var feedsList: Results<RealmRss>
    var foldersList: Results<Folder>
            
    init() {
        realm = try! Realm()
        feedsList = realm.objects(RealmRss.self)
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
    
    func save(feed: RealmRss, to folder: Folder?) {
        write {
            if let folder = folder {
                folder.feeds.append(feed)
            } else {
                defaultFolder.feeds.append(feed)
            }
        }
    }
    
    func delete(news: RealmNews) {
        write {
            realm.delete(news)
        }
    }
    
    func delete(feed: RealmRss) {
        feed.news.forEach({self.delete(news: $0)})
        write {
            realm.delete(feed)
        }
    }
    
    func delete(folder: Folder) {
        folder.feeds.forEach {self.delete(feed: $0)}
        write {
            realm.delete(folder)
        }
    }
    
    func update(news: RealmNews, isRead: Bool) {
        write {
            news.isRead = isRead
        }
    }
    
    func update(feed: RealmRss, new url: String?, new title: String?, new categories: [String]?) {
        write {
            feed.title = title ?? ""
            feed.url = url ?? ""
            if let categories = categories {
                feed.categories.removeAll()
                feed.categories.append(objectsIn: categories)
            }
        }
    }
    
    func update(folder: Folder, title: String) {
        write {
            folder.name = title
        }
    }
    
    func move(feed: RealmRss, to folder: Folder) {
        write {
            guard let index = defaultFolder.feeds.index(of: feed) else {
                assertionFailure("No such feed in default folder")
                return
            }
            defaultFolder.feeds.remove(at: index)
            folder.feeds.append(feed)
        }
    }
    
    func moveToDefault(feed: RealmRss, from folder: Folder) {
        write {
            guard let index = folder.feeds.index(of: feed) else {
                assertionFailure("No such feed in folder \(folder.name)")
                return
            }
            folder.feeds.remove(at: index)
            defaultFolder.feeds.append(feed)
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
