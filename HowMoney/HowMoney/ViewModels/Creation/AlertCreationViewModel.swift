//
//  AlertCreationViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 15/11/2022.
//

import Foundation

class AlertCreationViewModel: CreationViewModel {
    
    private var targetCurrency: PreferenceCurrency
    
    override init(service: any Service) {
        targetCurrency = .usd
        super.init(service: service)
        self.context = .alert
    }
    
    override func create(successCompletion: @escaping () -> Void,
                         failureCompletion: @escaping () -> Void) {
        guard let selectedAsset = selectedAsset else {
            errorMessage = Localizable.alertsCreationAssetSelectionValidation.value
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
                let result = try await service.sendData(requestValues: .alert(value: value,
                                                                              originAssetName: selectedAsset.name.lowercased(),
                                                                              targetCurrencyName: targetCurrency.name.lowercased()))
                guard let _ = result as? Alert else {
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
    
    func updateTargetCurrency(_ currencyIndex: Int) {
        self.targetCurrency = PreferenceCurrency.allCases[currencyIndex]
    }
    
}
