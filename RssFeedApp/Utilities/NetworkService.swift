//
//  NetworkService.swift
//  RssFeedApp
//
//  Created by Dmitry on 18.11.2020.
//

import Foundation
import XMLCoder

protocol NetworkServiceProtocol: AutoMockable {
    func fetchData(from url: String, completion: @escaping ((Result<Feed?, Error>) -> Void))
}

class NetworkService: NetworkServiceProtocol {
    func fetchData(from url: String, completion: @escaping ((Result<Feed?, Error>) -> Void)) {
        guard let url = URL(string: url) else {
            completion(.failure(NetworkErrors.invalidUrl))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if error != nil {
                completion(.failure(NetworkErrors.networkError))
            }
            if let data = data {
                do {
                    let decoder = XMLDecoder()
                    decoder.shouldProcessNamespaces = true
                    let feed = try decoder.decode(RawFeed.self, from: data)
                    let rssFeed = Feed(feed: feed)
                    completion(.success(rssFeed))
                } catch {
                    completion(.failure(NetworkErrors.parsingFailure))
                }
            }
        }.resume()
    }
    
}
