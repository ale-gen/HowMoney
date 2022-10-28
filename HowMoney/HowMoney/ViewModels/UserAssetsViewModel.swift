//
//  UserAssetsViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 27/10/2022.
//

import Foundation

class UserAssetsViewModel: ObservableObject {
    
    @Published var filteredUserAssets: [UserAsset] = []
    var selectedFilter: AssetFilter {
        didSet {
            filteredUserAssets = userAssets.filter({ userAsset in
                selectedFilter.possibleAssetTypes.contains(userAsset.asset.type) })
        }
    }
    
    private var userAssets: [UserAsset]
    
    init() {
        userAssets = UserAsset.UserAssetsMock
        selectedFilter = .all
    }
    
    
}
