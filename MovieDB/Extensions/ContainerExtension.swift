//
//  ContainerExtension.swift
//  MovieDB
//
//  Created by Le Chris on 19.11.2023.
//

import Foundation
import Swinject

extension Container {
    static var shared: Container = {
        let container = Container()
        return container
    }()
}
