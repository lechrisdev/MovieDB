//
//  SearchMoviesResponse.swift
//  MovieDB
//
//  Created by Le Chris on 19.11.2023.
//

import Foundation

struct SearchMoviesResponse: Codable {
    let page: Int
    let results: [MovieResponse]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

extension SearchMoviesResponse {
    var domain: [MovieModel] {
        results.map {
            MovieModel(
                title: $0.title,
                year: $0.releaseDate.extractYear(),
                posterUrl: Requests.imageBaseUrl + $0.posterPath
            )
        }
    }
}
