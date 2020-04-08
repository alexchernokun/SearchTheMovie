//
//  Movie.swift
//  SearchTheMovie
//
//  Created by Alex Chernokun on 08.04.2020.
//  Copyright © 2020 Alex Chernokun. All rights reserved.
//

import Foundation

struct Movies: Codable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "Search"
    }
    
    static func instance(from data: Data) -> Movies? {
        return try? JSONDecoder().decode(Movies.self, from: data) 
    }
}

struct Movie: Codable {
    let title: String
    let year: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
    }
    
    static func instance(from data: Data) -> Movie {
        return try! JSONDecoder().decode(Movie.self, from: data)
    }
}
