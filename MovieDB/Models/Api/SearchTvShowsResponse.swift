//
//  SearchTvShowsResponse.swift
//  MovieDB
//
//  Created by Le Chris on 19.11.2023.
//

import Foundation

struct SearchTvShowsResponse: Codable {
    let page: Int
    let results: [TvShowResponse]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

extension SearchTvShowsResponse {
    var domain: [MovieModel] {
        results.map {
            MovieModel(
                title: $0.name,
                year: $0.firstAirDate.extractYear(),
                posterUrl: Requests.imageBaseUrl + $0.posterPath
            )
        }
    }
}
