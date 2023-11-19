//
//  WelcomeTitleView.swift
//  MovieDB
//
//  Created by Le Chris on 18.11.2023.
//

import SwiftUI

struct WelcomeTitleView: View {
    
    private let filterButtonTapped: () -> Void
    
    init(filterButtonTapped: @escaping () -> Void) {
        self.filterButtonTapped = filterButtonTapped
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Welcome!")
                    .font(.system(size: 28))
                    .fontWeight(.medium)
                    .foregroundStyle(Color.accentColor)
                Text("Set up filters and search for your favorite movies")
                    .font(.system(size: 15))
                    .fontWeight(.regular)
                    .foregroundStyle(Color("lightGrayColor"))
            }
            Spacer()
            Button(action: {
                filterButtonTapped()
            }, label: {
                ZStack {
                    Circle().frame(width: 48, height: 48)
                        .foregroundStyle(Color("mediumGrayColor"))
                    Image(systemName: "slider.vertical.3")
                        .foregroundStyle(Color("darkWhiteColor"))
                }
            })
        }
        .padding()
    }
    
}

struct WelcomeTitleView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeTitleView(filterButtonTapped: {})
            .background(Color("backgroundColor"))
    }
}
