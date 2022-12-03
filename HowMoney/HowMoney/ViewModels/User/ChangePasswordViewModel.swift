//
//  ChangePasswordViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 06/11/2022.
//

import SwiftUI

class ChangePasswordViewModel: ObservableObject {
    
    var toastType: ToastType {
        return ToastViewModel.shared.toast.type
    }
    
    var toastMessage: String {
        return ToastViewModel.shared.toast.message
    }
    
    func changePassword(successCompletion: @escaping () -> Void,
                        failureCompletion: @escaping () -> Void) {
        ToastViewModel.shared.update(message: Localizable.changePasswordSuccesText.value, type: .success)
        successCompletion()
        
//        ToastViewModel.shared.update(message: Localizable.toastViewFailedOperationMessageText.value, type: .error)
//        failureCompletion()
    }
    
}
