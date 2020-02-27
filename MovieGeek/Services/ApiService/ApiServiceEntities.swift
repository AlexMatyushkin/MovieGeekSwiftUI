//
//  ApiServiceEntities.swift
//  MovieGeek
//
//  Created by 17503583 on 27.02.2020.
//  Copyright © 2020 Aleksay Matyushkin. All rights reserved.
//

import Foundation

enum Endpoint {
    case searchMovies
    
    var endpoint: URLComponents {
        var component = URLComponents()
        component.scheme = "https"
        component.host = "api.themoviedb.org"
        
        switch self {
        case .searchMovies:
            component.path = "/3/search/movie"
        }
        
        return component
    }
}


// MARK: - Result
struct Movies: Codable {
    let page, totalResults, totalPages: Int?
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Movie
struct Movie: Codable, Identifiable {
    let popularity: Double
    let voteCount: Int
    let video: Bool
    var posterPath: String?
    let id: Int
    let adult: Bool
    let backdropPath: String?
    let originalTitle: String
    let genreIDS: [Int]
    let title: String
    let voteAverage: Double
    let overview, releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id, adult
        case backdropPath = "backdrop_path"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}
