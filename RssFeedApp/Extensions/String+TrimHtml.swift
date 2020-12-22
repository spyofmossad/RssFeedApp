//
//  StringExtension.swift
//  RssFeedApp
//
//  Created by Dmitry on 22.12.2020.
//

import Foundation

extension String {
    var trimmedHtml: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
