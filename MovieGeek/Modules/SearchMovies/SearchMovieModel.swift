//
//  SearchMovieModel.swift
//  MovieGeek
//
//  Created by 17503583 on 26.02.2020.
//  Copyright © 2020 Aleksay Matyushkin. All rights reserved.
//

import Foundation
import Combine

class SearchMovieModel: ObservableObject {
    let apiService = APIService()
    var subscriptions = Set<AnyCancellable>()
    @Published var movies: [Movie] = []
    
    func getMovies() {
        apiService.searchMovies(movieName: "Star")?
            .sink(receiveCompletion: { _ in }, receiveValue: { value in
                self.movies = value.results
            })
            .store(in: &subscriptions)
        
    }
    
    init() {
        getMovies()
    }
}
