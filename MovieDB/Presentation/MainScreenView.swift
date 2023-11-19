//
//  MainScreenView.swift
//  MovieDB
//
//  Created by Le Chris on 20.11.2023.
//

import SwiftUI
import Swinject

struct MainScreenView: View {
    
    enum MainTab {
        case home
        case search
        case favorites
        case account
    }
    
    @State var selection: MainTab = .home
    
    var body: some View {
        TabView(selection: $selection) {
            MainView(
                viewModel: Container.shared.resolve(MainViewModel.self)!,
                filterViewModel: Container.shared.resolve(FilterViewModel.self)!
            )
                .tabItem {
                    Image("film")
                    Text("Home")
                }
                .tag(MainTab.home)
            
            VStack {}
                .tabItem {
                    Image("search")
                    Text("Search")
                }
                .tag(MainTab.search)
            VStack {}
                .tabItem {
                    Image("heart")
                    Text("Favorites")
                }
                .tag(MainTab.favorites)
            VStack {}
                .tabItem {
                    Image("person")
                    Text("Account")
                }
                .tag(MainTab.account)
        }
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
