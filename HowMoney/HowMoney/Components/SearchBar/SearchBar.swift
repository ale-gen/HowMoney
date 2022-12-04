//
//  SearchBar.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 04/12/2022.
//

import SwiftUI

struct SearchBar: View {
    
    private enum Constants {
        enum Description {
            static let cornerRadius: CGFloat = 20.0
            static let height: CGFloat = 60.0
            static let color: Color = .white.opacity(0.13)
            static let horizontalInsets: CGFloat = 20.0
        }
    }
    
    @Binding var searchText: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: Constants.Description.cornerRadius)
            .fill(Constants.Description.color)
            .frame(height: Constants.Description.height)
            .overlay {
                TextField(Localizable.searchPlaceholder.value, text: $searchText)
                    .padding(.horizontal, Constants.Description.horizontalInsets)
            }
            .padding(.horizontal)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(.empty))
    }
}
