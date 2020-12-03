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
    
    func save(feed: RealmRss)
    func delete(feed: RealmRss)
    func update(feed: RealmRss, with newFeed: RealmRss)
}

class DataProvider: DataProviderProtocol {
    private var realm: Realm
    
    var feedsList: Results<RealmRss>
        
    init() {
        realm = try! Realm()
        feedsList = realm.objects(RealmRss.self)
    }
    
    func save(feed: RealmRss) {
        write {
            realm.add(feed)
        }
    }
    
    func delete(feed: RealmRss) {
        write {
            realm.delete(feed)
        }
    }
    
    func update(feed: RealmRss, with newFeed: RealmRss) {
        write {
            feed.title = newFeed.title
            feed.url = newFeed.url
            feed.categories = newFeed.categories
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
