//
//  MainChatEntites.swift
//  MovieGeek
//
//  Created by 17503583 on 28.02.2020.
//  Copyright © 2020 Aleksay Matyushkin. All rights reserved.
//

import SwiftUI

struct Message: Identifiable {
    var id = UUID()
    var userName: String
    var text: String
    var type: MessageType
    var router: MessageClass
    var movie: Movie?
    
    init(userName: String,
         text: String?,
         type: MessageType,
         router: MessageClass,
         movie: Movie? = nil ) {
        
        self.id = UUID()
        self.userName = userName
        self.text = text ?? ""
        self.type = type
        self.router = router
        self.movie = movie
    }
}

enum MessageType {
    case textMessage
    case movieMessage
}

enum MessageClass {
    case incoming
    case outcoming
}

// MARK: Answer


struct Answer: Identifiable {
    var id = UUID()
    let command: Command
}

enum Command {
    case searchMovie
    
    var description: String {
        switch self {
        case .searchMovie:
            return "Искать фильмы".localizedCapitalized
        }
    }
}
