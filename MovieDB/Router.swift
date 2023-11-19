//
//  Router.swift
//  MovieDB
//
//  Created by Le Chris on 19.11.2023.
//

import SwiftUI
import UIKit
import Swinject

class Router {
    private var navigationController: UINavigationController?
    
    func configureNavigationController() {
        if navigationController == nil {
            let vc = UIHostingController(rootView: MainScreenView())
            navigationController = UINavigationController(rootViewController: vc)
            navigationController?.title = ""
            
            UIApplication
                .shared
                .connectedScenes
                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                .last { $0.isKeyWindow }?.rootViewController = navigationController
        }
    }
    
    func showFilterViewScreen(vm: FilterViewModel) {
        let vc = UIHostingController(rootView: FilterView(viewModel: vm))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func back(animated: Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }
}
