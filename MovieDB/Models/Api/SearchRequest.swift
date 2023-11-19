//
//  SearchRequest.swift
//  MovieDB
//
//  Created by Le Chris on 19.11.2023.
//

import Foundation

struct SearchRequest {
    let category: Category.CategoryName
    let yearFrom: Int
    let yearTo: Int
    let genres: [Int]
}
