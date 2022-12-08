//
//  CreationViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 15/11/2022.
//

import Foundation

class CreationViewModel: ObservableObject {
    
    private enum Constants {
        static let defaultValue: String = .zero
        static let defaultPossibleDecimalPlaces: Int = 8
    }
    
    @Published var selectedAsset: Asset?
    @Published var presentNextStep: Bool = false
    
    var keyboardViewModel: KeyboardViewModel?
    var service: any Service
    var task: Task<(), Never>?
    var context: CreationContext?
    
    var currencySymbol: String {
        return selectedAsset?.symbol ?? .empty
    }
    
    init(service: any Service) {
        self.service = service
    }
    
    func create(successCompletion: @escaping () -> Void,
                failureCompletion: @escaping () -> Void) {
        /* */
    }
    
    func navigateToNextStep(_ failureCompletion: @escaping () -> Void) {
        guard let _ = selectedAsset else {
            ToastViewModel.shared.update(message: Localizable.userAssetsCreationAssetSelectionValidation.value, type: .error)
            failureCompletion()
            return
        }
        presentNextStep = true
    }
    
    func prepareAssetsCollectionViewModel() -> ListViewModel<Asset> {
        return ListViewModel(service: Services.assetService,
                             didSelectItem: didSelectAsset)
    }
    
    func prepareKeyboardViewModel() -> KeyboardViewModel {
        let keyboardVM = KeyboardViewModel(assetType: context == .asset ? (selectedAsset?.type ?? .currency) : .currency)
        self.keyboardViewModel = keyboardVM
        return keyboardVM
    }
    
    private func didSelectAsset(_ asset: Asset) {
        selectedAsset = asset
    }
    
}
