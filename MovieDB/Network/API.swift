//
//  API.swift
//  MovieDB
//
//  Created by Le Chris on 19.11.2023.
//

import Foundation
import Alamofire

class API {
    static func sendRequestData(request: EndPoint) async throws -> Data? {
        
        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMDk2NjkxYjM2YjJkN2ViODAxZTBmM2ExZTU2OTZlNCIsInN1YiI6IjY1NTg4OWUwY2EwZTE3MDEzYTFkMTIwNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ba37xQntXDbdrTqyD24Xmt-dXGf1BLqAdPz9R9Wa2FI"
        ]
        
        return try await AF.request(request.path,
                                    method: request.httpMethod,
                                    parameters: request.parameters,
                                    encoding: URLEncoding.default,
                                    headers: HTTPHeaders(headers))
        .validate(statusCode: 200..<300)
        .serializingData()
        .value
    }
}

// https://api.themoviedb.org/3/genre/movie/list

protocol EndPoint {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: Parameters? { get }
}

enum Requests: EndPoint {
    case getMovieGenres
    case getTvGenres
    case getNowPlaying
    case getTopRated
    case searchMovies(search: SearchRequest)
    case searchTvShows(search: SearchRequest)
    case searchCartoons(search: SearchRequest)
    
    static var baseUrl: String = "https://api.themoviedb.org/3"
    static var imageBaseUrl: String = "https://image.tmdb.org/t/p/w500"
    
    var path: String {
        switch self {
        case .getMovieGenres:
            return Requests.baseUrl + "/genre/movie/list"
        case .getTvGenres:
            return Requests.baseUrl + "/genre/tv/list"
        case .getNowPlaying:
            return Requests.baseUrl + "/movie/now_playing"
        case .getTopRated:
            return Requests.baseUrl + "/movie/top_rated"
        case .searchMovies:
            return Requests.baseUrl + "/discover/movie"
        case .searchTvShows:
            return Requests.baseUrl + "/discover/tv"
        case .searchCartoons:
            return Requests.baseUrl + "/discover/movie"
        }
    }

    var httpMethod: Alamofire.HTTPMethod {
        switch self {
        default:
            return .get
        }
    }

    var parameters: Parameters? {
        switch self {
        case .getMovieGenres:
            let parameters: [String: Encodable] = [
                "language": "en"
            ]
            return parameters
        case .getTvGenres:
            let parameters: [String: Encodable] = [
                "language": "en"
            ]
            return parameters
        case .getNowPlaying:
            let parameters: [String: Encodable] = [
                "language": "en-US",
                "page": 1
            ]
            return parameters
        case .getTopRated:
            let parameters: [String: Encodable] = [
                "language": "en-US",
                "page": 1
            ]
            return parameters
        case let .searchMovies(search):
            let parameters: [String: Encodable] = [
                "primary_release_date.gte": String(search.yearFrom) + "-01-01",
                "primary_release_date.lte": String(search.yearTo) + "-12-31",
                "with_genres": search.genres,
                "language": "en-US",
                "page": 1
            ]
            return parameters
        case .searchTvShows(search: let search):
            let parameters: [String: Encodable] = [
                "first_air_date.gte": String(search.yearFrom) + "-01-01",
                "first_air_date.lte": String(search.yearTo) + "-12-31",
                "with_genres": search.genres,
                "language": "en-US",
                "page": 1
            ]
            return parameters
        case .searchCartoons(search: let search):
            let parameters: [String: Encodable] = [
                "primary_release_date.gte": String(search.yearFrom) + "-01-01",
                "primary_release_date.lte": String(search.yearTo) + "-12-31",
                "with_genres": 16,
                "language": "en-US",
                "page": 1
            ]
            return parameters
        }
    }
}
