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
    var detailedInfo: DetailedInfo?
    
    @Published var title = ""
    @Published var budget = "0"
    
    
    init(movie: Movie?) {
        let movieId = movie?.id ?? 0
        
        self.apiService.loadDetailedMovieInfo(movieId: String(movieId))?
            .sink(receiveCompletion: { result in
                switch result {
                case .finished: break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            },
                  receiveValue: { [weak self] detailedInfo in
                    guard let self = self else { return }
                    self.detailedInfo = detailedInfo
            })
            .store(in: &subsrcibers)
    }
    
    func fillingModel() {
        
    }
}
