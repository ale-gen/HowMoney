//
//  ChangePasswordViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 06/11/2022.
//

import SwiftUI

class ChangePasswordViewModel: ObservableObject {
    
    @Published var currentPasswordTextField: String = .empty
    @Published var newPasswordTextField: String = .empty
    @Published var confirmedNewPasswordTextField: String = .empty
    
    private(set) var message: String = .empty
    private(set) var toastType: ToastType = .error
    
    func checkPasswordsCompatibility() -> Bool {
        guard !newPasswordTextField.isEmpty && !confirmedNewPasswordTextField.isEmpty else {
            message = Localizable.changePasswordEmptyFieldValidationText.value
            return false
        }
        
        if newPasswordTextField != confirmedNewPasswordTextField {
            message = Localizable.changePasswordCompatibilityValidationText.value
            return false
        }
        return true
    }
    
    func changePassword(_ completion: @escaping () -> Void) {
        guard !currentPasswordTextField.isEmpty else {
            message = Localizable.changePasswordEmptyFieldValidationText.value
            toastType = .error
            completion()
            return
        }
        
        guard checkPasswordsCompatibility() else {
            toastType = .error
            completion()
            return
        }
        toastType = .success
        message = Localizable.changePasswordSuccesText.value
        completion()
        clearTextFields()
    }
    
    private func clearMessage() {
        message = .empty
    }
    
    private func clearTextFields() {
        currentPasswordTextField = .empty
        newPasswordTextField = .empty
        confirmedNewPasswordTextField = .empty
    }
    
}
