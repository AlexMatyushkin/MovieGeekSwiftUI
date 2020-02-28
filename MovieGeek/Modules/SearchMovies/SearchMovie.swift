//
//  SearchMovie.swift
//  MovieGeek
//
//  Created by 17503583 on 26.02.2020.
//  Copyright © 2020 Aleksay Matyushkin. All rights reserved.
//

import SwiftUI
import Combine

struct SearchMovie: View {
    
    @ObservedObject private var model = SearchMovieModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter movie name..", text: $model.searchText)
                    .multilineTextAlignment(.center)
                List(model.movies) { movie in
                    NavigationLink(destination: AboutMovieView(movie: movie)) {
                        MoviePreviewCell(movie: movie)
                    }
                }
            }
        }
    }
}

struct SearchMovie_Previews: PreviewProvider {
    static var previews: some View {
        SearchMovie()
    }
}
