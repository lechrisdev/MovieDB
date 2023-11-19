//
//  AppAssembly.swift
//  MovieDB
//
//  Created by Le Chris on 19.11.2023.
//

import Foundation
import Swinject

class AppAssembly: Assembly {
    
    func assemble(container: Container) {
        
        // MARK: - Managers

        container.register(Router.self, factory: { _ in
            Router()
        })
        .inObjectScope(.container)
        
        container.register(RepositoryProtocol.self) { container in
            Repository()
        }
        .inObjectScope(.container)
        
        // MARK: - ViewModels
        container.register(MainViewModel.self, factory: { container in
            MainViewModel(
                router: container.resolve(Router.self)!,
                repository: container.resolve(RepositoryProtocol.self)!
            )
        })
        
        container.register(FilterViewModel.self, factory: { container in
            FilterViewModel(
                router: container.resolve(Router.self)!,
                repository: container.resolve(RepositoryProtocol.self)!
            )
        })
    }
}
