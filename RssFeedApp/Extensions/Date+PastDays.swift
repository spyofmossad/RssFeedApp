//
//  Date+PastDays.swift
//  RssFeedApp
//
//  Created by Dmitry on 10.12.2020.
//

import Foundation

extension Date {
    var beginOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        var dateComponents = DateComponents()
        dateComponents.day = 1
        dateComponents.second = -1
        
        return Calendar.current.date(byAdding: dateComponents, to: beginOfDay)!
    }
    
    var yesterday: Date {
        var dateComponents = DateComponents()
        dateComponents.hour = -24
        
        return Calendar.current.date(byAdding: dateComponents, to: self)!
    }
    
    var lastWeek: Date {
        var dateComponents = DateComponents()
        dateComponents.day = -7
        
        return Calendar.current.date(byAdding: dateComponents, to: self)!
    }
    
    func isBetween(_ date1: Date, and date2: Date) -> Bool {
            return (min(date1, date2) ... max(date1, date2)) ~= self
        }
}
