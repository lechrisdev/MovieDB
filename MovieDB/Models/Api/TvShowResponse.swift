//
//  TvShowResponse.swift
//  MovieDB
//
//  Created by Le Chris on 19.11.2023.
//

import Foundation

struct TvShowResponse: Codable {
//    let backdropPath: String
let firstAirDate: String
//    let genreIDS: [Int]
//    let id: Int
    let name: String
//    let originCountry: [String]
//    let originalName: String
//    let overview: String
//    let popularity: Double
    let posterPath: String
//    let voteAverage: Double
//    let voteCount: Int

    enum CodingKeys: String, CodingKey {
//        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
//        case genreIDS = "genre_ids"
//        case id
             case name
//        case originCountry = "origin_country"
//        case originalName = "original_name"
//        case overview, popularity
        case posterPath = "poster_path"
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
    }
}
