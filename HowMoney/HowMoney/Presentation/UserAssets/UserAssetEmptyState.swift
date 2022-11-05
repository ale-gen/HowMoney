//
//  UserAssetEmptyState.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 25/10/2022.
//

import SwiftUI

struct UserAssetEmptyState: View {
    
    let noUserAssetModel = EmptyStateModel(image: Images.noAssets.value, title: Localizable.userAssetsEmptyStateTitle.value, buttonTitle: Localizable.userAssetsCreateNewButtonTitle.value)
    @State private var shouldShowAssetCreationView: Bool = false
    
    var body: some View {
        EmptyStateView(model: noUserAssetModel, didButtonTapped: {
            shouldShowAssetCreationView.toggle()
        })
        .sheet(isPresented: $shouldShowAssetCreationView) {
            UserAssetCreationView()
        }
    }
    
}

struct UserAssetEmptyState_Previews: PreviewProvider {
    static var previews: some View {
        UserAssetEmptyState()
    }
}
