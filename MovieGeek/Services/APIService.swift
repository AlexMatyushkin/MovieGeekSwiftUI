//
//  APIService.swift
//  MovieGeek
//
//  Created by 17503583 on 26.02.2020.
//  Copyright © 2020 Aleksay Matyushkin. All rights reserved.
//

import Foundation
import Combine

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

class APIService {
    
    let apiKey = "6ac74b0da5730068415439d99321dbe5"
    
    var subscription = Set<AnyCancellable>()
    let passthrought = PassthroughSubject<Movies, Never>()
    
    func searchMovies(movieName: String) -> AnyPublisher<Movies, Error>? {
    
        var components = Endpoint.searchMovies.endpoint
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: "ru-RU"), // TODO -make different language
            URLQueryItem(name: "query", value: movieName),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "include_adult", value: "false")
        ]
        
        guard let url = components.url else { return nil}
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .receive(on: DispatchQueue.main)
            .decode(type: Movies.self, decoder: JSONDecoder())
            .catch { _ in Empty<Movies, Error>() }
            .eraseToAnyPublisher()
    }
}

// MARK: - Movie
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

// MARK: - Result
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
