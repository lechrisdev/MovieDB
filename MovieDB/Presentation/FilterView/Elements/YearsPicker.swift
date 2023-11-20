//
//  YearsPicker.swift
//  MovieDB
//
//  Created by Le Chris on 18.11.2023.
//

import SwiftUI

struct YearRangeSelectorView: View {
    @Binding private var startYear: Int
    @Binding private var endYear: Int
    
    init(startYear: Binding<Int>, endYear: Binding<Int>) {
        self._startYear = startYear
        self._endYear = endYear
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Year")
                .font(.system(size: 20))
                .fontWeight(.regular)
                .foregroundStyle(Color.white)
            HStack {
                Menu {
                    Picker(selection: $startYear) {
                        ForEach((1920...endYear).reversed(), id: \.self) {
                            Text(String($0))
                                .id($0)
                        }
                    } label: {}
                } label: {
                    HStack {
                        Text(String(startYear))
                            .padding()
                            .foregroundColor(.white.opacity(0.7))
                        Spacer()
                        Image(systemName: "chevron.down")
                            .padding(.trailing, 16)
                            .foregroundColor(.white.opacity(0.5))
                    }
                    .background(Color("gray"))
                    .cornerRadius(10)
                }.pickerStyle(.inline)
                Menu {
                    Picker(selection: $endYear) {
                        ForEach((startYear...Calendar.current.component(.year, from: Date())).reversed(), id: \.self) {
                            Text(String($0))
                                .id($0)
                        }
                    } label: {}
                } label: {
                    HStack {
                        Text(String(endYear))
                            .padding()
                            .foregroundColor(.white.opacity(0.7))
                        Spacer()
                        Image(systemName: "chevron.down")
                            .padding(.trailing, 16)
                            .foregroundColor(.white.opacity(0.5))
                    }
                    .background(Color("gray"))
                    .cornerRadius(10)
                }.pickerStyle(.inline)
            }
        }
    }
}

struct YearRangeSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
            ScrollView {
                YearRangeSelectorView(startYear: .constant(1980), endYear: .constant(2023))
            }
        }
    }
}

