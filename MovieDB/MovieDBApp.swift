//
//  MovieDBApp.swift
//  MovieDB
//
//  Created by Le Chris on 19.11.2023.
//

import SwiftUI
import Swinject

@main
struct MovieDBApp: App {
    
    var body: some Scene {
        WindowGroup {
            EmptyView()
                .onAppear {
                    _ = Assembler([AppAssembly()],
                                  container: Container.shared)
                    Container.shared.resolve(Router.self)!.configureNavigationController()
                }
        }
    }
}
