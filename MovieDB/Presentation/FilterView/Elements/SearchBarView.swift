//
//  SearchBarView.swift
//  MovieDB
//
//  Created by Le Chris on 18.11.2023.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .trailing) {

            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color("gray"))
            RoundedRectangle(cornerRadius: 10)
                .stroke(style: .init(lineWidth: 1))
                .foregroundStyle(Color("statusColor"))
            
            TextField("enter genre name", text: $text)
                .textFieldStyle(.plain)
                .padding(12)
                .foregroundStyle(.white)
            
            Button(action: {
                text = ""
            }, label: {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 14, height: 14)
                .foregroundStyle(Color("statusColor"))
                .padding(.trailing, 16)
            })
        }.fixedSize(horizontal: false, vertical: true)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
            SearchBarView(text: .constant(""))
        }
    }
}
