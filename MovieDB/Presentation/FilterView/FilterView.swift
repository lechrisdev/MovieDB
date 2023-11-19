//
//  FilterView.swift
//  MovieDB
//
//  Created by Le Chris on 18.11.2023.
//

import SwiftUI

struct FilterView: View {
    
    @ObservedObject var viewModel: FilterViewModel
    
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    FilterListView(type: .category, viewModel: viewModel.filterViewModel)
                    FilterListView(type: .genres, viewModel: viewModel.filterViewModel)
                    YearRangeSelectorView(startYear: $viewModel.startYear, endYear: $viewModel.endYear)
                    GenreTagButton(state: .search, title: "Search", searchTapped: {
                        viewModel.searchTapped.send(())
                    }).padding(.top, 37)
                }
                .padding(.top, 16)
                .padding(.horizontal, 16)
            }
        }.onAppear { viewModel.getAllGenres() }
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal, content: {
                Text("Filters")
                    .font(.system(size: 17))
                    .fontWeight(.regular)
                    .foregroundColor(Color("darkWhiteColor"))
            })
            ToolbarItem(placement: .navigationBarLeading, content: {
                Button(action: {
                    viewModel.router.back()
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color("darkWhiteColor"))
                })
            })
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button(action: {
                    viewModel.resetAll()
                }, label: {
                    Text("Reset all")
                        .foregroundColor(Color("redColor"))
                        .font(.system(size: 17))
                        .fontWeight(.regular)
                })
            })
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(viewModel: FilterViewModel(router: Router(), repository: Repository()))
    }
}
