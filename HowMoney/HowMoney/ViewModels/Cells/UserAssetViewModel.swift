//
//  UserAssetViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 28/10/2022.
//

import SwiftUI


class UserAssetViewModel: ObservableObject {
    
    
    @Published var userAssetPriceHistory: [Float] = []
    
    var userAsset: UserAsset {
        editingViewModel?.userAsset ?? localUserAsset
    }
    
    var assetPricePercentageChangeValue: Float {
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
        self.assetVM = AssetViewModel(asset: userAsset.asset)
    }
    
    func prepareEditingViewModel(_ type: UserAssetOperation) -> UserAssetEditingViewModel {
        let editingVM = UserAssetEditingViewModel(service: Services.userAssetService, userAsset: userAsset, operation: type)
        self.editingViewModel = editingVM
        return editingVM
    }
    
    @MainActor func fetchPriceHistory() {
        assetVM.getExchangeRateHistory({ [weak self] in
            self?.userAssetPriceHistory = self?.assetVM.assetHistoryData.map { $0.value } ?? []
        }, { [weak self] in
            print("🫠 Cannot fetch exchange rates for asset: \(self?.userAsset.asset.friendlyName)")
        })
    }
    
    func getToastValues() -> ToastModel? {
        return editingViewModel?.toast
    }
    
}
