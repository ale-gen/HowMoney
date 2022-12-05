//
//  UserAssetCreationViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 29/10/2022.
//

import Foundation

class UserAssetCreationViewModel: CreationViewModel  {
    
    private let operation: UserAssetOperation
    private var origin: String
    
    override init(service: any Service) {
        self.operation = .add
        self.origin = .empty
        super.init(service: service)
        self.context = .asset
    }
    
    override func create(successCompletion: @escaping () -> Void,
                         failureCompletion: @escaping () -> Void) {
        guard let selectedAsset = selectedAsset else {
            ToastViewModel.shared.update(message: Localizable.userAssetsCreationAssetSelectionValidation.value, type: .error)
            failureCompletion()
            return
        }
        guard !origin.isEmpty else {
            ToastViewModel.shared.update(message: Localizable.userAssetsCreationOriginValidation.value, type: .error)
            return
        }
        guard let keyboardViewModel = keyboardViewModel,
              let value = Float(keyboardViewModel.textValue),
              value > .zero
        else {
            ToastViewModel.shared.update(message: Localizable.userAssetsCreationValueValidationToastMessageText.value, type: .error)
            failureCompletion()
            return
        }
        
        task = Task {
            do {
                let result = try await service.sendData(requestValues: .userAsset(assetName: selectedAsset.name.lowercased(),
                                                                                  value: value * operation.multiplier,
                                                                                  type: operation.requestValueType,
                                                                                  origin: origin))
                guard let _ = result as? UserAsset else {
                    ToastViewModel.shared.update(message: Localizable.toastViewFailedOperationMessageText.value, type: .error)
                    failureCompletion()
                    return
                }
                ToastViewModel.shared.update(message: Localizable.userAssetsCreationSuccessToastMessageText.value, type: .success)
                successCompletion()
            } catch let error {
                print("🆘 Error during user asset creation: \(error.localizedDescription)")
                ToastViewModel.shared.update(message: Localizable.toastViewFailedOperationMessageText.value, type: .error)
                failureCompletion()
            }
        }
    }
    
    override func navigateToNextStep(_ failureCompletion: @escaping () -> Void) {
        guard let _ = selectedAsset else {
            ToastViewModel.shared.update(message: Localizable.userAssetsCreationAssetSelectionValidation.value, type: .error)
            failureCompletion()
            return
        }
        guard !origin.isEmpty else {
            ToastViewModel.shared.update(message: Localizable.userAssetsCreationOriginValidation.value, type: .error)
            failureCompletion()
            return
        }
        presentNextStep = true
    }
    
    func updateOrigin(_ newValue: String) {
        origin = newValue
    }
    
    
    
}
