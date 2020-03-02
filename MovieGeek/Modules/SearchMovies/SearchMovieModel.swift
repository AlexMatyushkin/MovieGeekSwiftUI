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
    
    @Published var searchText = "" {
        didSet {
            if self.searchText.count < 1 {
                self.movies.removeAll()
            } else {
                self.getMovies(movieTitle: self.searchText)
            }
        }
    }
    
    @Published var movies: [Movie] = []
    
    func getMovies(movieTitle: String) {
        apiService.searchMovies(movieName: movieTitle)?
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.movies = value.results
            })
            .store(in: &subscriptions)
        
    }
    
}
