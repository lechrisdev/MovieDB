//
//  RoundedButton.swift
//  MovieDB
//
//  Created by Le Chris on 18.11.2023.
//

import SwiftUI

enum ButtonState {
    case unselected
    case deletable
    case marked
    case search
    
    var titleColor: Color {
        switch self {
        case .unselected:
            return Color(.white)
        case .deletable:
            return Color("statusColor")
        case .marked, .search:
            return Color(.white)
        }
    }
    
    var bgColor: Color {
        switch self {
        case .unselected:
            return Color("systemGray").opacity(0.5)
        case .deletable:
            return Color.clear
        case .marked, .search:
            return Color("statusColor")
        }
    }
}

struct GenreTagButton: View {
    
    private let searchTapped: () -> Void
    private let selected: (Bool) -> Void
    @State private var state: ButtonState
    private var title: String
    
    init(state: ButtonState,
         title: String,
         searchTapped: @escaping () -> Void = {},
         selected: @escaping (Bool) -> Void = {_ in}) {
        self.state = state
        self.title = title
        self.searchTapped = searchTapped
        self.selected = selected
    }
    
    var body: some View {
        Button(action: {
            withAnimation(.easeIn(duration: 0)) {
                switch state {
                case .unselected:
                    state = .deletable
                    selected(true)
                case .deletable:
                    state = .unselected
                    selected(false)
                case .marked:
                    state = .deletable
                    selected(true)
                case .search:
                    searchTapped()
                }
            }
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 100)
                    .foregroundStyle(state.bgColor)
                
                if state == .deletable {
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(style: .init(lineWidth: 1))
                        .foregroundStyle(state.titleColor)
                }
                
                HStack(spacing: 8) {
                    if state == .search {
                        Image(systemName: "magnifyingglass").resizable().frame(width: 14, height: 14).offset(y: 1)
                            .foregroundStyle(state.titleColor)
                    }
                    
                    Text(title)
                        .foregroundStyle(state.titleColor)
                        .font(.system(size: 17))
                        .fontWeight(.regular)
                    
                    if state == .deletable {
                        Image(systemName: "xmark").resizable().frame(width: 10, height: 10).offset(y: 1)
                            .foregroundStyle(state.titleColor)
                    }
                }.padding(.horizontal, 12).padding(.vertical, state == .search ? 13 : 8)
            }.fixedSize(horizontal: state != .search, vertical: true)
        })
    }
}

struct RoundedButtonPreview: View {
 
    @State var state: ButtonState
    let title: String
    
    var body: some View {
        GenreTagButton(state: state, title: title)
    }
    
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
            VStack {
                HStack {
                    RoundedButtonPreview(state: .unselected, title: "biography")
                    RoundedButtonPreview(state: .marked, title: "biography")
                    RoundedButtonPreview(state: .deletable, title: "biography")
                }
                RoundedButtonPreview(state: .search, title: "Search")
            }
        }
    }
}
