//
//  UserAssetEmptyState.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 25/10/2022.
//

import SwiftUI

struct UserAssetEmptyState: View {
    
    let noUserAssetModel = EmptyStateModel(image: Images.noAssets.value, title: Localizable.userAssetsEmptyStateTitle.value, buttonTitle: Localizable.userAssetsCreateNewButtonTitle.value)
    
    var body: some View {
            EmptyStateView(model: noUserAssetModel)
    }
    
}

struct UserAssetEmptyState_Previews: PreviewProvider {
    static var previews: some View {
        UserAssetEmptyState()
    }
}
