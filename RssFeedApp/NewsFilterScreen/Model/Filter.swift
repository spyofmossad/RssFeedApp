//
//  Filter.swift
//  RssFeedApp
//
//  Created by Dmitry on 14.12.2020.
//

import Foundation
import RealmSwift

class Filter: Object {
    let rssFeed = LinkingObjects(fromType: RealmRss.self, property: "filter")
    @objc dynamic var favorite = false
    @objc dynamic var read = false
    @objc dynamic var date = false
    @objc dynamic var dateTime = Date()
}
