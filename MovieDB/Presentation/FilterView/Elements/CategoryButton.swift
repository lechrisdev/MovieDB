//
//  CategoryButton.swift
//  MovieDB
//
//  Created by Le Chris on 18.11.2023.
//

import SwiftUI

struct CategoryButton: View {
    
    var model: Category
    let selected: (String) -> Void
    
    var body: some View {
        Button(action: {
            selected(model.name.rawValue)
        }, label: {
        ZStack {
            RoundedRectangle(cornerRadius: 100)
                .foregroundStyle(model.selected
                                 ? Color("statusColor")
                                 : Color("systemGray").opacity(0.5))
            
            HStack(spacing: 8) {
                Text(model.name.rawValue)
                    .foregroundStyle(.white)
                    .font(.system(size: 17))
                    .fontWeight(.regular)
                
            }.padding(.horizontal, 12).padding(.vertical, 8)
        }.fixedSize()
        })
    }
}

struct CategoryButton_Previews: PreviewProvider {
    static var previews: some View {
        CategoryButton(model: Category(selected: false, name: .movies), selected: {_ in})
    }
}
