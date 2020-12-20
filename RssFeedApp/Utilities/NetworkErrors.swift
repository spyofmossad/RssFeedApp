//
//  NetworkErrors.swift
//  RssFeedApp
//
//  Created by Dmitry on 20.12.2020.
//

import Foundation

enum NetworkErrors: Error {
    case invalidUrl
    case parsingFailure
    case networkError
}

extension NetworkErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return R.string.localizable.urlError()
        case .networkError:
            return R.string.localizable.networkError()
        case .parsingFailure:
            return R.string.localizable.parsingError()
        }
        
    }
}
