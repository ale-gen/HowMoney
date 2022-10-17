//
//  UserAssetsCollection.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 16/10/2022.
//

import SwiftUI

struct UserAssetsCollection: View {
    
    private enum Constants {
        static let horizontalInsets: CGFloat = 20.0
        static let contentHorizontalInsets: CGFloat = 10.0
        static let contentTopInsets: CGFloat = 20.0
        static let cornerRadius: CGFloat = 15.0
    }
    
    let userAssets: [UserAsset] = UserAsset.UserAssetsMock
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(.black)
            ScrollView {
                ForEach(userAssets, id: \.self) { userAsset in
                    UserAssetCell(userAsset: userAsset)
                        .listRowBackground(Color.black)
                }
            }
            .padding([.leading, .trailing], Constants.contentHorizontalInsets)
            .padding(.top, Constants.contentTopInsets)
            
        }
        .padding([.leading, .trailing], Constants.horizontalInsets)
        
    }
}

struct UserAssetsCollection_Previews: PreviewProvider {
    static var previews: some View {
        UserAssetsCollection()
    }
}
