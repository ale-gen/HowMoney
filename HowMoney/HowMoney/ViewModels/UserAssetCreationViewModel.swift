//
//  UserAssetCreationViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 29/10/2022.
//

import Foundation

class UserAssetCreationViewModel: ObservableObject {
    
    @Published var assets: [Asset]
    @Published var selectedAsset: Asset?
    
    init(/*assetService: AssetService*/) {
        self.assets = Asset.AssetsMock
    }
    
    func prepareAssetsCollectionViewModel() -> ListViewModel<Asset> {
        return ListViewModel(items: assets, didSelectItem: didSelectAsset)
    }
    
    private func didSelectAsset(_ asset: Asset) {
        selectedAsset = asset
    }
    
}
