//
//  AlertCreationViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 15/11/2022.
//

import Foundation

class AlertCreationViewModel: CreationViewModel {
    
    private var targetCurrency: PreferenceCurrency
    
    override var currencySymbol: String {
        targetCurrency.symbol
    }
    
    override init(service: any Service) {
        targetCurrency = PreferenceCurrency.allCases[.zero]
        super.init(service: service)
        self.context = .alert
    }
    
    override func create(successCompletion: @escaping () -> Void,
                         failureCompletion: @escaping () -> Void) {
        guard let selectedAsset = selectedAsset else {
            ToastViewModel.shared.update(message: Localizable.alertsCreationAssetSelectionValidation.value, type: .error)
            failureCompletion()
            return
        }
        guard let keyboardViewModel = keyboardViewModel,
              let value = Float(keyboardViewModel.textValue),
              value > .zero
        else {
            ToastViewModel.shared.update(message: Localizable.alertsCreationTargetValueValidation.value, type: .error)
            failureCompletion()
            return
        }
        
        task = Task {
            do {
                let result = try await service.sendData(requestValues: .alert(value: value,
                                                                              originAssetName: selectedAsset.name.lowercased(),
                                                                              targetCurrencyName: targetCurrency.name.lowercased()))
                guard let _ = result as? Alert else {
                    ToastViewModel.shared.update(message: Localizable.toastViewFailedOperationMessageText.value, type: .error)
                    failureCompletion()
                    return
                }
                ToastViewModel.shared.update(message: Localizable.alertsCreationSuccessToastMessageText.value, type: .success)
                successCompletion()
            } catch let error {
                print("Error during user asset creation: \(error.localizedDescription)")
                ToastViewModel.shared.update(message: Localizable.toastViewFailedOperationMessageText.value, type: .error)
                failureCompletion()
            }
        }
    }
    
    func updateTargetCurrency(_ currencyIndex: Int) {
        self.targetCurrency = PreferenceCurrency.allCases[currencyIndex]
    }
    
}
