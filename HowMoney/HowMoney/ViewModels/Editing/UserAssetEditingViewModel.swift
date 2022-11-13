//
//  UserAssetEditingViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 13/11/2022.
//

import SwiftUI

class UserAssetEditingViewModel: ObservableObject {
    
    var finalValue: Float {
        switch operation {
        case .add, .substract:
            return userAsset.originValue + operation.multiplier * (Float(keyboardViewModel?.textValue ?? "0.00") ?? 0.0)
        case .update:
            return Float(keyboardViewModel?.textValue ?? "0.00") ?? 0.0
        }
    }
    
    private(set) var userAsset: UserAsset
    private(set) var operation: UserAssetOperation
    
    private var service: any Service
    private var task: Task<(), Never>?
    private var keyboardViewModel: KeyboardViewModel?
    private var operationTypeRequestValue: String {
        switch operation {
        case .add, .substract:
            return "Update"
        case .update:
            return "Set"
        }
    }
    
    init(service: any Service, userAsset: UserAsset, operation: UserAssetOperation) {
        self.service = service
        self.userAsset = userAsset
        self.operation = operation
    }
    
    func prepareKeyboardViewModel() -> KeyboardViewModel {
        let keyboardVM = KeyboardViewModel(assetType: userAsset.asset.type)
        self.keyboardViewModel = keyboardVM
        return keyboardVM
    }
    
    func updateUserAsset(successCompletion: @escaping () -> Void,
                         failureCompletion: @escaping () -> Void) {
        guard let keyboardViewModel = keyboardViewModel,
              let value = Float(keyboardViewModel.textValue)
        else {
            failureCompletion()
            return
        }
        print(value)
        
        task = Task {
            do {
                let result = try await service.sendData(requestValues: .userAsset(assetName: userAsset.asset.name.lowercased(),
                                                                                  value: value * operation.multiplier,
                                                                                  type: operationTypeRequestValue))
                guard let result = result as? UserAsset else {
                    failureCompletion()
                    return
                }
                userAsset = result
                successCompletion()
            } catch let error {
                print("Error during user asset updating: \(error.localizedDescription)")
                failureCompletion()
            }
        }
    }
    
}
