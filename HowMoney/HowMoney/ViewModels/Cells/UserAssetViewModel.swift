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
        assetVM.dailyPercentagePriceChange
    }
    
    var assetPriceChangeImage: Image? {
        assetVM.assetDailyPriceChangeImage
    }
    
    var priceChangeColor: Color {
        assetVM.dailyPercentagePriceChange > .zero ? .green : (assetVM.dailyPercentagePriceChange < .zero ? .red : .white)
    }
    
    @Published var actualExchangeRate: Float = .zero
    
    var preferenceCurrencySymbol: String? {
        return preferenceCurrencyVM?.asset.symbol
    }
    
    private(set) var preferencyCurrencyExchangeRate: Float?
    private var localUserAsset: UserAsset
    private var preferenceCurrencyVM: AssetViewModel?
    private var assetVM: AssetViewModel
    private var editingViewModel: UserAssetEditingViewModel?
    
    init(userAsset: UserAsset, preferenceCurrency: PreferenceCurrency) {
        self.localUserAsset = userAsset
        self.assetVM = AssetViewModel(asset: userAsset.asset)
        self.preferenceCurrencyVM = preparePreferenceCurrencyViewModel(preferenceCurrency)
    }
    
    func prepareEditingViewModel(_ type: UserAssetOperation) -> UserAssetEditingViewModel {
        let editingVM = UserAssetEditingViewModel(service: Services.userAssetService, userAsset: userAsset, operation: type)
        self.editingViewModel = editingVM
        return editingVM
    }
    
    @MainActor func fetchPriceHistory(_ completion: @escaping () -> Void) {
        assetVM.getExchangeRateHistory({ [weak self] in
            self?.userAssetPriceHistory = self?.assetVM.assetHistoryData.map { $0.value } ?? []
            completion()
        }, { [weak self] in
            print("🫠 Cannot fetch exchange rates for asset: \(self?.userAsset.asset.friendlyName)")
        })
    }
    
    @MainActor func fetchPreferenceCurrencyPrice() {
        if preferenceCurrencyVM?.asset.name.lowercased() == PreferenceCurrency.usd.name.lowercased() {
            self.preferencyCurrencyExchangeRate = 1.0
            guard let preferencyCurrencyExchangeRate = preferencyCurrencyExchangeRate else { return }
            actualExchangeRate = (assetVM.actualPrice ?? .zero) / preferencyCurrencyExchangeRate
        } else {
            preferenceCurrencyVM?.getExchangeRateHistory { [weak self] in
                self?.preferencyCurrencyExchangeRate = self?.preferenceCurrencyVM?.assetHistoryData.last.map { $0.value }
                guard let preferencyCurrencyExchangeRate = self?.preferencyCurrencyExchangeRate else { return }
                self?.actualExchangeRate = (self?.assetVM.actualPrice ?? .zero) / preferencyCurrencyExchangeRate
            } _: { [weak self] in
                print("🫠 Cannot fetch exchange rates for preference currency: \(self?.preferenceCurrencyVM?.asset.friendlyName)")
            }
        }
    }
    
    func getToastValues() -> ToastModel? {
        return editingViewModel?.toast
    }
    
    private func preparePreferenceCurrencyViewModel(_ preferenceCurrency: PreferenceCurrency) -> AssetViewModel {
        let asset = Asset(name: preferenceCurrency.name, friendlyName: preferenceCurrency.friendlyName, symbol: preferenceCurrency.symbol, type: .currency)
        return AssetViewModel(asset: asset)
    }
    
}
