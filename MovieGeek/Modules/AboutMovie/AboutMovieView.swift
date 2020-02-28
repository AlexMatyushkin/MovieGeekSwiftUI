//
//  AboutMovieView.swift
//  MovieGeek
//
//  Created by 17503583 on 27.02.2020.
//  Copyright © 2020 Aleksay Matyushkin. All rights reserved.
//

import SwiftUI

struct AboutMovieView: View {
    @ObservedObject var model: AboutMovieModel
    
    var body: some View {
        Text("Hello")
            .onAppear {
                self.model.fillingModel()
        }
    }
    
    init(movie: Movie?) {
        self.model = AboutMovieModel(movie: movie)
    }
}
