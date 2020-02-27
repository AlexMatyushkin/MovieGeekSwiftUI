//
//  MoviePreviewCell.swift
//  MovieGeek
//
//  Created by 17503583 on 27.02.2020.
//  Copyright © 2020 Aleksay Matyushkin. All rights reserved.
//

import SwiftUI
import Combine

struct MoviePreviewCell: View {
   
    @ObservedObject var model: MoviePreviewModel
    
    var body: some View {
        VStack{
            Text(model.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            VStack{
                Spacer()
                Image.init(uiImage: model.image).resizable()
                    .frame(width: 150, height: 200, alignment: .center)
                Spacer()
                if model.overview != "" {
                    Text("Краткое описание").fontWeight(.bold)
                    Text(model.overview)
                } else {
                    Spacer()
                }
                
            }
            
        }
    }
    
    init(movie: Movie) {
        self.model = MoviePreviewModel(movie: movie)
    }
}
