//
//  UserAssetViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 28/10/2022.
//

import SwiftUI


class UserAssetViewModel: ObservableObject {
    
    var userAsset: UserAsset {
        editingViewModel?.userAsset ?? localUserAsset
    }
    
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
    
    private var localUserAsset: UserAsset
    private var assetVM: AssetViewModel
    private var editingViewModel: UserAssetEditingViewModel?
    
    init(userAsset: UserAsset) {
        self.localUserAsset = userAsset
        self.userAssetPriceHistory = AssetHistoryRecord.DollarHistoryMock.map { $0.value }
        self.assetVM = AssetViewModel(asset: userAsset.asset)
    }
    
    func prepareEditingViewModel(_ type: UserAssetOperation) -> UserAssetEditingViewModel {
        let editingVM = UserAssetEditingViewModel(service: Services.userAssetService, userAsset: userAsset, operation: type)
        self.editingViewModel = editingVM
        return editingVM
    }
    
}
