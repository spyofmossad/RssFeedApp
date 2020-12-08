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
    func save(feed: RealmRss, to folder: Folder)
    func delete(feed: RealmRss)
    func delete(folder: Folder)
    func update(feed: RealmRss, with newFeed: RealmRss)
    func update(folder: Folder, title: String)
    func move(feed: RealmRss, to newFolder: Folder)
    func moveToDefault(feed: RealmRss, from: Folder)
}

class DataProvider: DataProviderProtocol {
    private var realm: Realm
    
    var feedsList: Results<RealmRss>
    var foldersList: Results<Folder>
            
    init() {
        realm = try! Realm()
        feedsList = realm.objects(RealmRss.self)
        foldersList = realm.objects(Folder.self)
    }
    
    func save(folder: Folder) {
        write {
            realm.add(folder)
        }
    }
    
    func save(feed: RealmRss, to folder: Folder) {
        write {
            folder.feeds.append(feed)
        }
    }
    
    func delete(feed: RealmRss) {
        write {
            realm.delete(feed)
        }
    }
    
    func delete(folder: Folder) {
        folder.feeds.forEach { (feed) in
            self.delete(feed: feed)
        }
        write {
            realm.delete(folder)
        }
    }
    
    func update(feed: RealmRss, with newFeed: RealmRss) {
        write {
            feed.title = newFeed.title
            feed.url = newFeed.url
            feed.categories = newFeed.categories
        }
    }
    
    func update(folder: Folder, title: String) {
        write {
            folder.name = title
        }
    }
    
    func move(feed: RealmRss, to newFolder: Folder) {
        write {
            guard let defaultFolder = foldersList.first(where: { (folder) in
                folder.name == "Default"
            }) else { return }
            guard let index = defaultFolder.feeds.index(of: feed) else { return }
            defaultFolder.feeds.remove(at: index)
            newFolder.feeds.append(feed)
        }
    }
    
    func moveToDefault(feed: RealmRss, from: Folder) {
        write {
            if let defaultFolder = foldersList.filter("name == 'Default'").first {
                guard let index = from.feeds.index(of: feed) else { return }
                from.feeds.remove(at: index)
                defaultFolder.feeds.append(feed)
            }
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
