//
//  DataHelper.swift
//  RssFeedApp
//
//  Created by Dmitry on 10.12.2020.
//

import Foundation

class DateHelper {
    public static let shared = DateHelper()
    
    private let dateFormatter: DateFormatter
    
    private init() {
        dateFormatter = DateFormatter()
    }
    
    func getDate(from date: String) -> Date? {
        //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        //dateFormatter.dateFormat = "wd, dd mmm yyyy HH:mm:ss "
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: date)
    }
}
