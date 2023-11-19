//
//  FilterListViewModel.swift
//  MovieDB
//
//  Created by Le Chris on 19.11.2023.
//

import SwiftUI
import Combine

class FilterListViewModel: ObservableObject {
    
    @Published var categories: [Category] = [
        Category(selected: true, name: .movies),
        Category(selected: false, name: .cartoons),
        Category(selected: false, name: .tvseries)
    ]
    
    @Published var genres: [Genre] = []
    @Published var lastTappedIndex: Int = 0
    @Published var searchText: String = ""
    @Published var selectedGenres: [Genre] = []
    
    var selectedCategory = CurrentValueSubject<Category.CategoryName, Never>(.movies)
    private var cancelable = Set<AnyCancellable>()
    
    init() {
//        self.genres = genres
        
        $searchText
            .sink { [weak self] text in
                guard let self else { return }
                self.searchGenres(text: text)
            }.store(in: &cancelable)
        
        $categories
            .sink { [weak self] category in
                guard let selected = category.first(where: { $0.selected == true })?.name else { return }
                self?.selectedCategory.send(selected)
            }.store(in: &cancelable)
    }
    
    func selectCategory(name: String) {
        guard let markedIndex = self.categories.firstIndex(where: { $0.name.rawValue == name }) else { return }
        for index in 0...self.categories.count-1 {
            categories[index].selected = false
        }
        
        categories[markedIndex].selected = true
    }
    
    func addToGenres(selected: Bool, genre: Genre) {
        guard let selectedGenre = genres.first(where: { $0 == genre }) else { return }
        guard let markedIndex = self.genres.firstIndex(of: genre) else { return }
        if selected {
            if !selectedGenres.contains(selectedGenre) {
                selectedGenres.append(selectedGenre)
                genres[markedIndex].state = .deletable
            }
        } else {
            selectedGenres.removeAll(where: { $0.id == genre.id })
            genres[markedIndex].state = .unselected
        }
    }
    
    private func searchGenres(text: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            guard !self.genres.isEmpty else { return }
            for index in 0...self.genres.count-1 {
                if self.genres[index].state != .deletable { self.genres[index].state = .unselected }
            }
            if text.count >= 2 {
                for genre in self.genres {
                    guard let markedIndex = self.genres.firstIndex(of: genre) else { return }
                    if genre.name.lowercased().contains(text.lowercased()) {
                        if self.genres[markedIndex].state != .deletable {
                            self.genres[markedIndex].state = .marked
                        }
                    }
                }
            }
        }
    }
    
    func resetCategoriesAndGenres() {
        // reset categories
        for index in 0...categories.count-1 {
            categories[index].selected = false
        }
        categories[0].selected = true
        
        // reset genres
        for index in 0...genres.count-1 {
            genres[index].state = .unselected
        }
        
        selectedGenres = []
        selectedCategory.send(.movies)
        searchText = ""
    }
}
