//
//  NetworkService.swift
//  SearchTheMovie
//
//  Created by Alex Chernokun on 08.04.2020.
//  Copyright © 2020 Alex Chernokun. All rights reserved.
//

import Foundation

class NetworkService {
    
    let url = URL(string: Constants.Network.movieDBUrl)!
    
    func getMovieFromSearch(with title: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let searchUrl = URL(string: url.absoluteString + title) else { return }
        let task = URLSession.shared.dataTask(with: searchUrl) { (data, response, error) in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success(data))
        }
        
        task.resume()
    }
}
