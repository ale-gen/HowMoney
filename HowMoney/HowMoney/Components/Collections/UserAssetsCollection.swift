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
    
    let userAssets: [UserAsset]
    @State var selectedUserAsset: UserAsset?
    
    var body: some View {
        if userAssets.count > .zero {
            ZStack {
                RoundedRectangle(cornerRadius: Constants.Background.cornerRadius)
                    .fill(Constants.Background.color)
                    .shadow(color: Constants.Shadow.color, radius: Constants.Shadow.radius)
                ScrollView(showsIndicators: false) {
                    ForEach(userAssets, id: \.self) { userAsset in
                        UserAssetCell(userAsset: userAsset)
                            .listRowBackground(Color.black)
                            .onTapGesture {
                                withAnimation {
                                    selectedUserAsset = userAsset
                                }
                            }
                    }
                }
                .padding(.horizontal, Constants.contentHorizontalInsets)
                .padding(.vertical, Constants.contentTopInsets)
            }
            .sheet(item: $selectedUserAsset) { userAsset in
                UserAssetDetailsView(vm: UserAssetViewModel(userAsset: userAsset))
            }
        } else {
            VStack {
                Spacer()
                UserAssetEmptyState()
                Spacer()
            }
        }
    }
}

struct UserAssetsCollection_Previews: PreviewProvider {
    static var previews: some View {
        UserAssetsCollection(userAssets: UserAsset.UserAssetsMock)
            .background(.black)
            .environmentObject(UserStateViewModel(authService: AuthorizationService()))
    }
}
