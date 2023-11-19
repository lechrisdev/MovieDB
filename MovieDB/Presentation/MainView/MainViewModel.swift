//
//  MainViewModel.swift
//  MovieDB
//
//  Created by Le Chris on 19.11.2023.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    
    let router: Router
    let repository: RepositoryProtocol
    
    @Published var topRatedMovies: [MovieModel] = []
    @Published var nowPlayedMovies: [MovieModel] = []
    @Published var searchResults: [MovieModel] = []
    
    init(router: Router, repository: RepositoryProtocol) {
        self.router = router
        self.repository = repository
        
    }
    
    @MainActor
   func loadMovies() {
        loadTopRatedMovies()
    }
    
    @MainActor
    func loadCategory(request: SearchRequest) {
        searchResults = []
        Task {
            do {
                switch request.category {
                case .movies:
                    searchResults = try await repository.searchMovies(search: request)
                case .cartoons:
                    searchResults = try await repository.searchCartoons(search: request)
                case .tvseries:
                    searchResults = try await repository.searchTvShows(search: request)
                }
            } catch {
                print(error)
            }
        }
    }
    
    @MainActor
    private func loadTopRatedMovies() {
        Task {
            do {
                topRatedMovies = try await repository.getTopRated()
                nowPlayedMovies = try await repository.getNowPlaying()
                print(topRatedMovies)
            } catch {
                print(error)
            }
        }
    }
}
