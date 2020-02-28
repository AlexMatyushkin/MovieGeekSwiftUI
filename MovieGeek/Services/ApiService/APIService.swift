//
//  APIService.swift
//  MovieGeek
//
//  Created by 17503583 on 26.02.2020.
//  Copyright © 2020 Aleksay Matyushkin. All rights reserved.
//

import SwiftUI
import Combine

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
            .map { $0.data }
            .receive(on: DispatchQueue.main)
            .decode(type: Movies.self, decoder: JSONDecoder())
            .catch { _ in Empty<Movies, Error>() }
            .eraseToAnyPublisher()
    }
    
    func loadImage(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data}
            .receive(on: DispatchQueue.main)
            .catch { _ in Empty<Data, Error>() }
            .eraseToAnyPublisher()
    }
    
    func loadDetailedMovieInfo(movieId: String) -> AnyPublisher<DetailedInfo, Error>? {
        var components = Endpoint.searchMovies.endpoint
        
        components.queryItems = [
             URLQueryItem(name: "api_key", value: apiKey),
             URLQueryItem(name: "language", value: "ru-RU"),
             URLQueryItem(name: "movie_id", value: movieId)
        ]
        
        guard let url = components.url else { return nil }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .receive(on: DispatchQueue.main)
            .decode(type: DetailedInfo.self, decoder: JSONDecoder())
            .catch { _ in Empty<DetailedInfo, Error>() }
            .eraseToAnyPublisher()
    }
}
