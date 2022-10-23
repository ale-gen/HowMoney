//
//  UserAssetTabBar.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 18/10/2022.
//

import SwiftUI

struct UserAssetsTabBarItem: View {
    
    private enum Constants {
        static let verticalInsets: CGFloat = 20.0
        static let pickerVerticalInsets: CGFloat = 10.0
    }
    
    @Binding var searchText: String
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                filterAssetTypePicker
                
                UserAssetsCollection()
            }
            .searchable(text: $searchText)
        }
        .padding(.vertical, Constants.verticalInsets)
    }
    
    private var filterAssetTypePicker: some View {
        HStack {
            Spacer()
            Text("All")
            Spacer()
            Text("Assets")
            Spacer()
            Text("Cryptos")
            Spacer()
            Text("Metals")
            Spacer()
        }
        .foregroundColor(.white)
        .padding(.vertical, Constants.pickerVerticalInsets)
    }
}

struct UserAssetTabBar_Previews: PreviewProvider {
    static var previews: some View {
        UserAssetsTabBarItem(searchText: .constant(""))
    }
}
