//
//  DataExtension.swift
//  MovieDB
//
//  Created by Le Chris on 19.11.2023.
//

import Foundation

extension Data {
    func convertTo<SomeData: Decodable>(_ dataModel: SomeData.Type) -> SomeData? {
        do {
            let result = try JSONDecoder().decode(dataModel, from: self)
            return result
        } catch let error {
            print(error)
            return nil
        }
    }
}
