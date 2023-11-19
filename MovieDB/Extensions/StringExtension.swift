//
//  StringExtension.swift
//  MovieDB
//
//  Created by Le Chris on 19.11.2023.
//

import Foundation

extension String {
    func extractYear() -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            return year
        }
        return nil
    }
}
