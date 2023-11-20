//
//  CarouselView.swift
//  MovieDB
//
//  Created by Le Chris on 18.11.2023.
//

import SwiftUI

struct CarouselView: View {
    
    enum CarouselType {
        case searchResults
        case nowPlaying
        case popular
        
        var title: String {
            switch self {
            case .searchResults:
                return "Search Results"
            case .nowPlaying:
                return "Now Playing"
            case .popular:
                return "Popular"
            }
        }
    }
    
    let type: CarouselType
    let movies: [MovieModel]
    
    var body: some View {
        VStack {
            HStack {
                Text(type.title)
                    .font(.system(size: 20))
                    .fontWeight(.regular)
                    .foregroundStyle(Color("darkWhiteColor"))
                Spacer()
                Text("See all")
                    .font(.system(size: 15))
                    .fontWeight(.regular)
                    .foregroundStyle(Color("darkGrayColor"))
            }.padding(.horizontal, 16)
            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(movies, id: \.title) { movie in
                        MovieCell(cellSize: type == .nowPlaying || type == .searchResults ? .normal : .small, model: movie)
                            .padding(.bottom, 10)
                            .fixedSize()
                    }
                }
            }
        }
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        
        let movies = [
            MovieModel(
                title: "The Godfather",
                year: 1972,
                posterUrl: "https://image.tmdb.org/t/p/w500/3bhkrj58Vtu7enYsRolD1fZdja1.jpg"
            ),
            MovieModel(
                title: "The Shawshank Redemption",
                year: 1994,
                posterUrl: "https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg"
            ),
            MovieModel(
                title: "The Godfather Part II",
                year: 1974,
                posterUrl: "https://image.tmdb.org/t/p/w500/hek3koDUyRQk7FIhPXsa6mT2Zc3.jpg"
            ),
            MovieModel(
                title: "Schindler's List",
                year: 1993,
                posterUrl: "https://image.tmdb.org/t/p/w500/sF1U4EUQS8YHUYjNl3pMGNIQyr0.jpg"
            )
        ]
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
            VStack {
                CarouselView(type: .nowPlaying, movies: movies)
                CarouselView(type: .popular, movies: movies)
            }
        }
    }
}
