//
//  NetworkService.swift
//  RssFeedApp
//
//  Created by Dmitry on 18.11.2020.
//

import Foundation
import XMLCoder

protocol NetworkServiceProtocol {
    func fetchData(from url: String, completion: @escaping ((Result<RealmRss?, Error>) -> Void))
}

class NetworkService: NetworkServiceProtocol {
    func fetchData(from url: String, completion: @escaping ((Result<RealmRss?, Error>) -> Void)) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let decoder = XMLDecoder()
                    decoder.shouldProcessNamespaces = true
                    let feed = try decoder.decode(Rss.self, from: data)
                    let rssFeed = RealmRss(feed: feed)
                    completion(.success(rssFeed))
                } catch (let error) {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
}
