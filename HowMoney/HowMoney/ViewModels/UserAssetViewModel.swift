//
//  UserAssetViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 28/10/2022.
//

import SwiftUI


class UserAssetViewModel: ObservableObject {
    
    var userAsset: UserAsset
    var userAssetPriceHistory: [CGFloat]
    
    var assetPricePercentageChangeValue: CGFloat {
        assetVM.percentagePriceChange
    }
    
    var assetPriceChangeImage: Image? {
        assetVM.assetPriceChangeImage
    }
    
    var priceChangeColor: Color {
        assetVM.percentagePriceChange > .zero ? .green : (assetVM.percentagePriceChange < .zero ? .red : .white)
    }
    
    private var assetVM: AssetViewModel
    
    init(userAsset: UserAsset) {
        self.userAsset = userAsset
        self.userAssetPriceHistory = AssetHistoryRecord.DollarHistoryMock.map { $0.value }
        self.assetVM = AssetViewModel(asset: userAsset.asset)
    }
    
}
