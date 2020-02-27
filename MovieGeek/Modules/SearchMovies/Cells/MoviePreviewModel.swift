//
//  MoviePreviewModel.swift
//  MovieGeek
//
//  Created by 17503583 on 27.02.2020.
//  Copyright © 2020 Aleksay Matyushkin. All rights reserved.
//

import UIKit
import Combine

class MoviePreviewModel: ObservableObject {
    
    @Published var image: UIImage = UIImage()
    let apiService = APIService()
    var subsribers = Set<AnyCancellable>()
    
    init(stringURL: String) {
        if let url = URL(string: "https://image.tmdb.org/t/p/w500" + stringURL) {
            apiService.loadImage(url: url).sink(receiveCompletion: { _ in }, receiveValue: { data in
                if let image = UIImage(data: data) {
                    self.image = image
                }
            })
            .store(in: &subsribers)
        } else {
            if let image = UIImage(named: "backgroundMovie") {
                self.image = image
            }
        }
    }
}
