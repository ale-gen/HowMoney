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
    @Published var errorMessage: String = .empty
    
    private let operation: UserAssetOperation
    private var service: any Service
    private var keyboardViewModel: KeyboardViewModel?
    private var task: Task<(), Never>?
    
    init(service: any Service) {
        self.operation = .add
        self.service = service
    }
    
    func prepareAssetsCollectionViewModel() -> ListViewModel<Asset> {
        return ListViewModel(service: Services.assetService,
                             didSelectItem: didSelectAsset)
    }
    
    func prepareKeyboardViewModel() -> KeyboardViewModel {
        let keyboardVM = KeyboardViewModel(assetType: selectedAsset?.type ?? .currency)
        self.keyboardViewModel = keyboardVM
        return keyboardVM
    }
    
    func createAsset(successCompletion: @escaping () -> Void,
                     failureCompletion: @escaping () -> Void) {
        guard let selectedAsset = selectedAsset else {
            errorMessage = Localizable.userAssetsCreationAssetSelectionValidation.value
            return
        }
        guard let keyboardViewModel = keyboardViewModel,
              let value = Float(keyboardViewModel.textValue)
        else {
            errorMessage = "Value has to be in correct format"
            failureCompletion()
            return
        }
        
        task = Task {
            do {
                let result = try await service.sendData(requestValues: .userAsset(assetName: selectedAsset.name.lowercased(),
                                                                                  value: value * operation.multiplier,
                                                                                  type: operation.requestValueType))
                guard let _ = result as? UserAsset else {
                    failureCompletion()
                    return
                }
                successCompletion()
            } catch let error {
                print("Error during user asset creation: \(error.localizedDescription)")
                failureCompletion()
            }
        }
    }
    
    private func didSelectAsset(_ asset: Asset) {
        selectedAsset = asset
    }
    
}
