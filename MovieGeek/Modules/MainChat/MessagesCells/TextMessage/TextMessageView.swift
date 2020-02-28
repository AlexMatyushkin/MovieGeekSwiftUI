//
//  TextMessageView.swift
//  MovieGeek
//
//  Created by 17503583 on 28.02.2020.
//  Copyright © 2020 Aleksay Matyushkin. All rights reserved.
//

import SwiftUI

struct TextMessageView: View {
    
    var contentAligment: HorizontalAlignment
    var frameAligmnet: Alignment
    let leftSpacerWidth: CGFloat
    let rightSpacerWidth: CGFloat
    var userName: String
    var messageText: String
    
    var body: some View {
        HStack {
            Spacer()
                .frame(width: leftSpacerWidth)
                .frame(minWidth: leftSpacerWidth)
            VStack(alignment: contentAligment, spacing: 10) {
                HStack {
                    Spacer()
                        .frame(width: leftSpacerWidth)
                    Text(userName)
                    Spacer()
                        .frame(width: rightSpacerWidth)
                }
                HStack {
                    Spacer()
                        .frame(width: leftSpacerWidth)
                    Text(messageText)
                    Spacer()
                        .frame(width: rightSpacerWidth)
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(UIColor.white), lineWidth: 2)
            )
            
            Spacer()
                .frame(width: rightSpacerWidth)
            
        }
    }
    
    init(message: Message) {
        switch message.router {
        case .incoming:
            self.contentAligment = .leading
            self.frameAligmnet = .leading
            self.leftSpacerWidth = CGFloat(10.00)
            self.rightSpacerWidth = CGFloat(40.00)
        case .outcoming:
            self.contentAligment = .trailing
            self.frameAligmnet = .trailing
            self.leftSpacerWidth = CGFloat(40.00)
            self.rightSpacerWidth = CGFloat(10.00)
        }
        self.userName = message.userName + ":"
        self.messageText = message.text ?? ""
    }
}

struct TextMessageView_Previews: PreviewProvider {
    static var previews: some View {
        TextMessageView(message: Message(userName: "Alex", text: "Hi", type: .textMessage, router: .incoming))
    }
}
