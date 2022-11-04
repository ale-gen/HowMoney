//
//  UserAssetCreationViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 29/10/2022.
//

import Foundation

class UserAssetCreationViewModel: ObservableObject {
    
    @Published var assets: [Asset]
    @Published var selectedAsset: Asset = Asset.AssetsMock.first!
    
    @Published var assetValueLabel: String = .empty
    @Published var assetValue: Float = 0.00
    
    init(/*assetService: AssetService*/) {
        self.assets = Asset.AssetsMock
        self.assetValueLabel = "\(assetValue)"
    }
    
    func prepareAssetsCollectionViewModel() -> ListViewModel<Asset> {
        return ListViewModel(items: assets, didSelectItem: didSelectAsset)
    }
    
    func updateAssetValueLabel(_ tappedButton: KeyboardButtonType) {
        // TODO: Make complex validation
        switch tappedButton {
        case let .number(stringNumber):
            assetValueLabel += stringNumber
        case .clear:
            guard assetValueLabel.count > 1 else {
                assetValueLabel = "0.00"
                return
            }
            assetValueLabel.removeLast()
        case let .decimalComma(char):
            guard !assetValueLabel.contains(char) else { return }
            assetValueLabel.append(char)
        }
    }
    
    func createAsset(_ successCompletion: @escaping () -> Void) {
        successCompletion()
    }
    
    private func didSelectAsset(_ asset: Asset) {
        selectedAsset = asset
    }
    
}
