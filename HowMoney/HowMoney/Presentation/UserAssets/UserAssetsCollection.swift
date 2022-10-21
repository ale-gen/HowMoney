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
        enum Background {
            static let color: Color = .black
            static let cornerRadius: CGFloat = 15.0
        }
        enum Shadow {
            static let color: Color = .black.opacity(0.9)
            static let radius: CGFloat = 15.0
        }
    }
    
    let userAssets: [UserAsset] = UserAsset.UserAssetsMock
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.Background.cornerRadius)
                .fill(Constants.Background.color)
                .shadow(color: Constants.Shadow.color, radius: Constants.Shadow.radius)
            ScrollView {
                ForEach(userAssets, id: \.self) { userAsset in
                    UserAssetCell(userAsset: userAsset)
                        .listRowBackground(Color.black)
                }
            }
            .padding(.horizontal, Constants.contentHorizontalInsets)
            .padding(.vertical, Constants.contentTopInsets)
            
        }
    }
}

struct UserAssetsCollection_Previews: PreviewProvider {
    static var previews: some View {
        UserAssetsCollection()
            .background(.black)
    }
}
