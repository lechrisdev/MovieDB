//
//  MainView.swift
//  MovieDB
//
//  Created by Le Chris on 19.11.2023.
//

import SwiftUI
//import Combine

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    @ObservedObject var filterViewModel: FilterViewModel
    
    init(viewModel: MainViewModel, filterViewModel: FilterViewModel) {
        self.viewModel = viewModel
        self.filterViewModel = filterViewModel
    }
    
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
            ScrollView {
                WelcomeTitleView(filterButtonTapped: {
                    viewModel.router.showFilterViewScreen(vm: filterViewModel)
                })
                if !viewModel.searchResults.isEmpty {
                    CarouselView(type: .searchResults, movies: viewModel.searchResults)
                }
                CarouselView(type: .nowPlaying, movies: viewModel.nowPlayedMovies)
                CarouselView(type: .popular, movies: viewModel.topRatedMovies)
            }
        }
        // 
        .onReceive(filterViewModel.searchTapped, perform: { tap in
            guard tap != nil else { return }
            guard let searchRequest = filterViewModel.searchRequest.value else { return }
            viewModel.loadCategory(request: searchRequest)
            filterViewModel.resetAll()
            filterViewModel.router.back()
        })
        .onAppear {
            viewModel.loadMovies()
        }
        .navigationBarHidden(true)
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let router = Router()
        let repository = Repository()
        MainView(viewModel: MainViewModel(router: router, repository: repository),
                 filterViewModel: FilterViewModel(router: router, repository: repository))
    }
}
