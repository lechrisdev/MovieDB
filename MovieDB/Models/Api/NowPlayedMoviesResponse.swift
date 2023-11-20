//
//  NowPlayedMoviesResponse.swift
//  MovieDB
//
//  Created by Le Chris on 20.11.2023.
//

import Foundation

struct NowPlayedMoviesResponse: Codable {
    let dates: Dates
    let page: Int
    let results: [NowPlayedMovies]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String
}

// MARK: - Result
struct NowPlayedMovies: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension NowPlayedMoviesResponse {
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
