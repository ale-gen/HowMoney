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
    
    @Published var assets: [Asset]
    @Published var selectedAsset: Asset?
    
    @Published var assetValueLabel: String = Constants.defaultValue
    @Published var assetValue: Float = .zero
    @Published var errorMessage: String = .empty
    
    
    init(/*assetService: AssetService*/) {
        self.assets = Asset.AssetsMock
    }
    
    func prepareAssetsCollectionViewModel() -> ListViewModel<Asset> {
        return ListViewModel(items: assets, didSelectItem: didSelectAsset)
    }
    
    func updateAssetValueLabel(_ tappedButton: KeyboardButtonType) {
        // TODO: Make complex validation
        switch tappedButton {
        case let .number(stringNumber):
            guard assetValueLabel != Constants.defaultValue else {
                assetValueLabel = stringNumber
                return
            }
            if let currentDecimalPlaces = assetValueLabel.split(separator: ".").last?.count,
               currentDecimalPlaces < selectedAsset?.type.decimalPlaces ?? Constants.defaultPossibleDecimalPlaces {
                assetValueLabel += stringNumber
            } else {
                errorMessage = Localizable.userAssetsCreationDecimalPlacesValidation.value
            }
        case .clear:
            guard assetValueLabel.count > 1 else {
                assetValueLabel = Constants.defaultValue
                return
            }
            assetValueLabel.removeLast()
        case let .decimalComma(char):
            guard !assetValueLabel.contains(char) else { return }
            assetValueLabel.append(char)
        }
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
