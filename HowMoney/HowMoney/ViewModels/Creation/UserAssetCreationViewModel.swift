//
//  UserAssetCreationViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 29/10/2022.
//

import Foundation

class UserAssetCreationViewModel: ObservableObject {
    
    private enum Constants {
        static let defaultValue: String = "0.00"
        static let defaultPossibleDecimalPlaces: Int = 8
    }
    
    @Published var selectedAsset: Asset?
    
    @Published var assetValueLabel: String = Constants.defaultValue
    @Published var assetValue: Float = .zero
    @Published var errorMessage: String = .empty
    
    func prepareAssetsCollectionViewModel() -> ListViewModel<Asset> {
        return ListViewModel(service: Services.assetService,
                             didSelectItem: didSelectAsset)
    }
    
    func prepareKeyboardViewModel() -> KeyboardViewModel {
        return KeyboardViewModel(assetType: selectedAsset?.type ?? .currency)
    }
    
    func createAsset(_ successCompletion: @escaping () -> Void) {
        convertEnteredValue()
        guard selectedAsset != nil else {
            errorMessage = Localizable.userAssetsCreationAssetSelectionValidation.value
            return
        }
        guard assetValue > .zero else {
            errorMessage = Localizable.userAssetsCreationPositiveNumberValidation.value
            return
        }
        successCompletion()
    }
    
    private func convertEnteredValue() {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        assetValue = numberFormatter.number(from: assetValueLabel)?.floatValue ?? .zero
    }
    
    private func didSelectAsset(_ asset: Asset) {
        selectedAsset = asset
    }
    
}
