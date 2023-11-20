//
//  FilterListView.swift
//  MovieDB
//
//  Created by Le Chris on 18.11.2023.
//

import SwiftUI

struct FilterListView: View {
    
    @ObservedObject private var viewModel: FilterListViewModel
    
    enum FilterListType {
        case category
        case genres
        
        var title: String {
            switch self {
            case .category:
                return "Category"
            case .genres:
                return "Genres"
            }
        }
        
        var foregroundColor: Color {
            switch self {
            case .category:
                return Color("darkWhiteColor")
            case .genres:
                return Color("statusColor")
            }
        }
    }
    
    private let type: FilterListType
    
    init(type: FilterListType, viewModel: FilterListViewModel) {
        self.viewModel = viewModel
        self.type = type
    }
    
    var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                
                HStack {
                    Text(type.title)
                        .font(.system(size: 20))
                        .fontWeight(.regular)
                        .foregroundStyle(type.foregroundColor)
                }
                    
                    switch type {
                    case .genres:
                        
                            SearchBarView(text: $viewModel.searchText)
                            .disabled(viewModel.genres.isEmpty)
                            .saturation(viewModel.genres.isEmpty ? 0 : 1)
                            .opacity(viewModel.genres.isEmpty ? 0.4 : 1)
                        
                            VStack {
                                _FlexibleView(availableWidth: UIScreen.main.bounds.width - 20,
                                              data: viewModel.genres,
                                              spacing: 8,
                                              alignment: .leading) { genre in
                                    GenreTagButton(state: genre.state,
                                                   title: genre.name,
                                                   selected: { selected in
                                        viewModel.searchText = ""
                                        viewModel.addToGenres(selected: selected, genre: genre)
                                    })
//                                }
                            }
                            }.padding(.top, 4)
                        
                    case .category:
                        HStack {
                            ForEach(viewModel.categories, id: \.name) { category in
                                CategoryButton(model: category, selected: { name in
                                    viewModel.selectCategory(name: name)
                                })
                            }
                        }
                    }
            }.fixedSize(horizontal: false, vertical: true)
            
//        }
    }
}

struct FilterListView_Previews: PreviewProvider {
    static var previews: some View {
        let genres = [
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
        
        let vm = FilterListViewModel()
        
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    FilterListView(type: .category, viewModel: vm)
                    FilterListView(type: .genres, viewModel: vm)
                }
            }
        }
    }
}

