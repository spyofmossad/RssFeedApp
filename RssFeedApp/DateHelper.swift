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
    
    func parse(from date: String) -> Date? {
        dateFormatter.dateFormat = "E, dd MMM yyyy HH:mm:ss Z"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: date)
    }
    
    func toString(from date: Date) -> String {
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
}
