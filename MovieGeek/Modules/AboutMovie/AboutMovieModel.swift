//
//  AboutMovieModel.swift
//  MovieGeek
//
//  Created by 17503583 on 27.02.2020.
//  Copyright © 2020 Aleksay Matyushkin. All rights reserved.
//

import SwiftUI
import Combine

class AboutMovieModel: ObservableObject {
    let apiService = APIService()
    var subsrcibers = Set<AnyCancellable>()
    
    init(movie: Movie) {
        
        apiService.loadDetailedMovieInfo(movieId: String(movie.id))?
            .sink(receiveCompletion: { _ in},
                  receiveValue: { detailedInfo in
                    print(detailedInfo)
            })
            .store(in: &subsrcibers)
    }
}
