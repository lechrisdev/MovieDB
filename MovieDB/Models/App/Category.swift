//
//  Category.swift
//  MovieDB
//
//  Created by Le Chris on 18.11.2023.
//

import SwiftUI

struct Category: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(selected)
        hasher.combine(name)
    }
    
    enum CategoryName: String {
        case movies = "Movies"
        case cartoons = "Cartoons"
        case tvseries = "TV Series"
    }
    
    var selected: Bool
    let name: CategoryName
    
    init(selected: Bool, name: CategoryName) {
        self.selected = selected
        self.name = name
    }
}
