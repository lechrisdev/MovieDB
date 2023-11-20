//
//  MovieCell.swift
//  MovieDB
//
//  Created by Le Chris on 18.11.2023.
//

import SwiftUI
import Kingfisher

struct MovieCell: View {
    
    enum CellSize {
        case normal
        case small
        
        var width: CGFloat {
            switch self {
            case .normal:
               return 194
            case .small:
                return 128
            }
        }
        
        var height: CGFloat {
            switch self {
            case .normal:
                return 272
            case .small:
                return 176
            }
        }
    }
    
    private let model: MovieModel
    private let cellSize: CellSize
    
    init(cellSize: CellSize, model: MovieModel) {
        self.cellSize = cellSize
        self.model = model
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                Image("default-movie")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(8)
                    .frame(width: cellSize.width, height: cellSize.height)
                KFImage(URL(string: model.posterUrl))
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(8)
                    .frame(width: cellSize.width, height: cellSize.height)
            }
            Group {
                Text(model.title)
                    .font(.system(size: 17))
                    .fontWeight(.regular)
                    .foregroundStyle(Color("darkWhiteColor"))
//                    .fixedSize(horizontal: false, vertical: true)
                if let year = model.year {
                    Text(String(year))
                        .font(.system(size: 15))
                        .fontWeight(.regular)
                        .foregroundStyle(Color("darkGrayColor"))
                }
            }.padding(.horizontal, 6)
        }.frame(width: cellSize.width)
    }
}

struct MovieCell_Previews: PreviewProvider {
    static var previews: some View {
        let model = MovieModel(
            title: "The Godfather: Long story with a long title",
            year: 1972,
            posterUrl: "https://image.tmdb.org/t/p/w500/3bhkrj58Vtu7enYsRolD1fZdja1.jpg"
        )
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
            VStack {
                MovieCell(cellSize: .normal, model: model)
                MovieCell(cellSize: .small, model: model)
            }
        }
    }
}
