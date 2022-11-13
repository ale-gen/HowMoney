//
//  UserAssetEditingViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 13/11/2022.
//

import Foundation

class UserAssetEditingViewModel: ObservableObject {
    
    @Published var finalValue: Float = 0.0
    
    private(set) var userAsset: UserAsset
    private(set) var operation: UserAssetOperation
    
    private var service: any Service
    private var operationTypeRequestValue: String {
        switch operation {
        case .add, .substract:
            return "Update"
        case .update:
            return "Set"
        }
    }
    
    private var task: Task<(), Never>?
    
    init(service: any Service, userAsset: UserAsset, operation: UserAssetOperation) {
        self.service = service
        self.userAsset = userAsset
        self.operation = operation
    }
    
    func updateUserAsset(successCompletion: @escaping () -> Void,
                         failureCompletion: @escaping () -> Void) {
        task = Task {
            do {
                let result = try await service.sendData(requestValues: .userAsset(assetName: userAsset.asset.name.lowercased(),
                                                                                  value: 30,
                                                                                  type: operationTypeRequestValue))
                guard let _ = result else {
                    failureCompletion()
                    return
                }
                successCompletion()
            } catch let error {
                print("Error during user asset updating: \(error.localizedDescription)")
                failureCompletion()
            }
        }
    }
    
}
