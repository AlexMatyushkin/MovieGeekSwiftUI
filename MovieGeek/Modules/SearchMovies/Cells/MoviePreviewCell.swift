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
    var title: String
    
    @ObservedObject var model: MoviePreviewModel
    
    var body: some View {
        VStack{
            Text(title)
            Image.init(uiImage: model.image).resizable()
                .frame(width: 150, height: 200, alignment: .center)
            .position(x: 100, y: 100)
        }
    }
    
    init(title: String, stringURL: String?) {
        self.title = title
        if let string = stringURL {
            self.model = MoviePreviewModel(stringURL: string)
        } else {
            self.model = MoviePreviewModel(stringURL: "")
        }
    }
}

struct MoviePreviewCell_Previews: PreviewProvider {
    static var previews: some View {
        MoviePreviewCell(title: "Kino", stringURL: nil)
    }
}
