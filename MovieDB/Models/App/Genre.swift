//
//  Genre.swift
//  MovieDB
//
//  Created by Le Chris on 18.11.2023.
//

import SwiftUI

struct Genre: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(state)
    }
    
    var state: ButtonState
    let id: Int
    let name: String
    
    init(state: ButtonState = .unselected, id: Int, name: String) {
        self.state = state
        self.id = id
        self.name = name
    }
}
