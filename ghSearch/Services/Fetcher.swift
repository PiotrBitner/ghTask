//
//  Fetcher.swift
//  ghSearch
//
//  Created by Piotr Bitner on 19/02/2020.
//  Copyright © 2020 Piotr Bitner. All rights reserved.
//

import Foundation
import Combine

class Fetcher {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
       self.session = session
     }
    
    func fetchRepository(searchTerm: String) -> AnyPublisher<Repository, FetchError>{
         return fetch(with: repositoryComponents(searchTerm: searchTerm))
    }
    
    enum FetchError: Error {
               case decodying(description: String)
               case network(description: String)
     }
    
    struct RepositoryAPI {
      static let scheme = "https"
      static let host = "api.github.com"
      static let path = "/search/repositories"
    }

    func repositoryComponents(searchTerm: String)-> URLComponents{

        var components = URLComponents()
        components.scheme = RepositoryAPI.scheme
        components.host = RepositoryAPI.host
        components.path = RepositoryAPI.path

        components.queryItems = [
          URLQueryItem(name: "q", value: searchTerm),
          URLQueryItem(name: "in", value: "description"),
          URLQueryItem(name: "sort", value: "stars"),
          URLQueryItem(name: "order", value: "desc")
        ]
            
        return components
    }

    private func fetch<T>(with components: URLComponents) -> AnyPublisher<T, FetchError> where T: Decodable {
       guard let url = components.url else {
         let error = FetchError.network(description: "Couldn't create URL")
         return Fail(error: error).eraseToAnyPublisher()
       }
       return session.dataTaskPublisher(for: URLRequest(url: url))
         .mapError { error in
           .network(description: error.localizedDescription)
         }
         .flatMap(maxPublishers: .max(1)) { pair in
            self.decode(pair.data)
         }
         .eraseToAnyPublisher()
     }

    private func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, FetchError> {
      let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(githubFormatter)
   
        return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
          .decodying(description: error.localizedDescription)
        }
        .eraseToAnyPublisher()
    }

}

