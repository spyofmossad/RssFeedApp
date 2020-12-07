//
//  NetworkService.swift
//  RssFeedApp
//
//  Created by Dmitry on 18.11.2020.
//

import Foundation
import XMLCoder

protocol NetworkServiceProtocol {
    func fetchData(from url: String, completion: @escaping ((Result<Rss?, Error>) -> Void))
}

class NetworkService: NetworkServiceProtocol {
    func fetchData(from url: String, completion: @escaping ((Result<Rss?, Error>) -> Void)) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let feed = try XMLDecoder().decode(Rss.self, from: data)
                    completion(.success(feed))
                } catch (let error) {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
}
