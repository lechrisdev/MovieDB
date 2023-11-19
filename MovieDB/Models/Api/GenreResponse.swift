//
//  GenreResponse.swift
//  MovieDB
//
//  Created by Le Chris on 19.11.2023.
//

import Foundation

struct GenresResponse: Codable {
    let genres: [GenreResponse]
}

// MARK: - Genre
struct GenreResponse: Codable {
    let id: Int
    let name: String
}
extension GenresResponse {
    var domain: [Genre] {
        genres.map({ Genre(id: $0.id, name: $0.name) })
    }
}
