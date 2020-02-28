//
//  MainChatView.swift
//  MovieGeek
//
//  Created by 17503583 on 28.02.2020.
//  Copyright © 2020 Aleksay Matyushkin. All rights reserved.
//

import SwiftUI
import Combine

struct MainChatView: View {
    
    @ObservedObject var model = MainChatViewModel()
    @ObservedObject private var keyboardObserver = KeyboardObserver()
    
    var body: some View {
        NavigationView {
            VStack{
                List(model.messages) { message in
                    if message.type == .textMessage {
                        HStack {
                            if message.router == .outcoming {
                                Spacer()
                            }
                            TextMessageView(message: message)
                        }
                    } else {
                        NavigationLink(destination: AboutMovieView(movie: message.movie)) {
                            MoviePreviewCell(movie: message.movie)
                        }
                    }
                    
                }.onAppear { UITableView.appearance().separatorStyle = .none }
                
                
                if !model.isShowTextField {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(model.answers) { answer in
                                Text(" " + answer.command.description + " ")
                                    .font(.system(size: 20, weight: .semibold, design: .monospaced))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.white, lineWidth: 1)
                                )
                                    .cornerRadius(20)
                                    .gesture(
                                        TapGesture()
                                            .onEnded { _ in
                                                self.model.commandRecived(answer.command)
                                        }
                                )
                            }
                        }
                    }.frame(height: 100)
                } else {
                    HStack{
                        TextField("Введите название фильма...", text: $model.textFieldText)
                        Button(action: {
                            self.model.searchMovie()
                        }, label: {
                            Text("Искать")
                        })
                    }
                }
            }.padding(.bottom, keyboardObserver.keyboardHeight)
            .navigationBarTitle("Чат с ботом")
        }
    }
    
    
}

struct MainChatView_Previews: PreviewProvider {
    static var previews: some View {
        MainChatView()
    }
}
