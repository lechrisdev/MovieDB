//
//  Repository.swift
//  MovieDB
//
//  Created by Le Chris on 19.11.2023.
//

import Foundation

protocol RepositoryProtocol {
    func getMovieGenres() async throws -> [Genre]
    func getTvGenres() async throws -> [Genre]
    func getTopRated() async throws -> [MovieModel]
    func getNowPlaying() async throws -> [MovieModel]
    func searchMovies(search: SearchRequest) async throws -> [MovieModel]
    func searchTvShows(search: SearchRequest) async throws -> [MovieModel]
    func searchCartoons(search: SearchRequest) async throws -> [MovieModel]
}

class Repository: RepositoryProtocol {
    
    func getMovieGenres() async throws -> [Genre] {
        guard let response = try await API.sendRequestData(request: Requests.getMovieGenres)?
            .convertTo(GenresResponse.self)?.domain else { return [] }
        return response
    }
    
    func getTvGenres() async throws -> [Genre] {
        guard let response = try await API.sendRequestData(request: Requests.getTvGenres)?
            .convertTo(GenresResponse.self)?.domain else { return [] }
        return response
    }
    
    func getTopRated() async throws -> [MovieModel] {
        guard let response = try await API.sendRequestData(request: Requests.getTopRated)?
            .convertTo(TopRatedMoviesResponse.self)?.domain else { return [] }
        return response
    }
    
    func getNowPlaying() async throws -> [MovieModel] {
        guard let response = try await API.sendRequestData(request: Requests.getNowPlaying)?
            .convertTo(NowPlayedMoviesResponse.self)?.domain else { return [] }
        return response
    }
    
    func searchMovies(search: SearchRequest) async throws -> [MovieModel] {
        guard let response = try await API.sendRequestData(request: Requests.searchMovies(search: search))?
            .convertTo(SearchMoviesResponse.self)?.domain else { return [] }
        return response
    }
    
    func searchTvShows(search: SearchRequest) async throws -> [MovieModel] {
        guard let response = try await API.sendRequestData(request: Requests.searchTvShows(search: search))?
            .convertTo(SearchTvShowsResponse.self)?.domain else { return [] }
        return response
    }
    
    func searchCartoons(search: SearchRequest) async throws -> [MovieModel] {
        guard let response = try await API.sendRequestData(request: Requests.searchCartoons(search: search))?
            .convertTo(SearchMoviesResponse.self)?.domain else { return [] }
        return response
    }
    


    
    
//    func getPosts() async throws -> [String] {
////        guard let response = try await API.sendRequestData(request: Requests.getPosts)?
////            .convertTo(PostsResponse.self)?.domain else { return [] }
//        return ["response"]
//    }
//
//    func getDetails(id: Int) async throws -> String? {
////        guard let response = try await API.sendRequestData(request: Requests.getDetail(postId: id))?
////            .convertTo(DetailResponse.self)?.domain else { return nil }
//        return "response"
//    }
}
