//
//  FilterViewModel.swift
//  MovieDB
//
//  Created by Le Chris on 18.11.2023.
//

import Foundation
import Combine

class FilterViewModel: ObservableObject {
    
    @Published private var moviesGenres: [Genre] = []
    @Published private var tvGenres: [Genre] = []

    @Published var startYear: Int = 1980
    @Published var endYear: Int = Calendar.current.component(.year, from: Date())
    
    var searchRequest = CurrentValueSubject<SearchRequest?, Never>(nil)
    var searchTapped = CurrentValueSubject<Void?, Never>(nil)
    private var cancelable = Set<AnyCancellable>()
    
    var filterViewModel = FilterListViewModel()
    
    var router: Router
    private let repository: RepositoryProtocol
    
    init(router: Router, repository: RepositoryProtocol) {
        
        self.moviesGenres = [
            Genre(id: 28, name: "Action"),
            Genre(id: 12, name: "Adventure"),
            Genre(id: 16, name: "Animation"),
            Genre(id: 35, name: "Comedy"),
            Genre(id: 80, name: "Crime"),
            Genre(id: 99, name: "Documentary"),
            Genre(id: 18, name: "Drama"),
            Genre(id: 10751, name: "Family"),
            Genre(id: 14, name: "Fantasy"),
            Genre(id: 36, name: "History"),
            Genre(id: 27, name: "Horror"),
            Genre(id: 10402, name: "Music"),
            Genre(id: 9648, name: "Mystery"),
            Genre(id: 10749, name: "Romance"),
            Genre(id: 878, name: "Science Fiction"),
            Genre(id: 10770, name: "TV Movie"),
            Genre(id: 53, name: "Thriller"),
            Genre(id: 10752, name: "War"),
            Genre(id: 37, name: "Western")
        ]
        
        self.router = router
        self.repository = repository
        
        filterViewModel.selectedCategory.sink { [weak self] category in
            guard let self else { return }
            switch category {
            case .movies:
                self.filterViewModel.genres = self.moviesGenres
            case .cartoons:
                self.filterViewModel.genres = []
            case .tvseries:
                self.filterViewModel.genres = self.tvGenres
            }
        }.store(in: &cancelable)
        
        Publishers
            .CombineLatest4(filterViewModel.selectedCategory,
                           filterViewModel.$selectedGenres,
                           $startYear,
                           $endYear)
            .sink { [weak self] category, genres, start, end  in
                guard let self else { return }
                print("🤡", category, genres.map({ $0.id }), start, end)
                self.searchRequest.send(
                    SearchRequest(
                        category: category,
                        yearFrom: start,
                        yearTo: end,
                        genres: genres.map { $0.id }
                    )
                )
            }.store(in: &cancelable)
    }
    
    @MainActor
    func getAllGenres() {
        Task {
            do {
                moviesGenres = try await repository.getMovieGenres()
                tvGenres = try await repository.getTvGenres()
                self.filterViewModel.genres = moviesGenres
            } catch {
                print(error)
            }
        }
    }
    
    func resetAll() {
        filterViewModel.resetCategoriesAndGenres()
        startYear = 1980
        endYear = Calendar.current.component(.year, from: Date())
    }
    
}
