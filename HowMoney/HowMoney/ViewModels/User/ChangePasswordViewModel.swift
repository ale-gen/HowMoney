//
//  ChangePasswordViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 06/11/2022.
//

import SwiftUI

class ChangePasswordViewModel: ObservableObject {
    
    private var service: any Service
    private var task: Task<(), Never>?
    
    var toastType: ToastType {
        return ToastViewModel.shared.toast.type
    }
    
    var toastMessage: String {
        return ToastViewModel.shared.toast.message
    }
    
    init(service: any Service) {
        self.service = service
    }
    
    func changePassword(successCompletion: @escaping () -> Void,
                        failureCompletion: @escaping () -> Void) {
        task = Task {
            do {
                let result = try await service.resetPassword()
                guard result else {
                    ToastViewModel.shared.update(message: Localizable.toastViewFailedOperationMessageText.value, type: .error)
                    failureCompletion()
                    return
                }
                ToastViewModel.shared.update(message: Localizable.changePasswordSuccesText.value, type: .success)
                successCompletion()
            } catch let error {
                ToastViewModel.shared.update(message: Localizable.toastViewFailedOperationMessageText.value, type: .error)
                print("🆘 Error during reset password request sending: \(error.localizedDescription)")
                failureCompletion()
            }
        }
        
    }
    
}
