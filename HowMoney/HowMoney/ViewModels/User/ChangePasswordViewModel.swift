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
    
    @Published var errorMessage: String = .empty
    
    func checkPasswordsCompatibility() -> Bool {
        guard !newPasswordTextField.isEmpty && !confirmedNewPasswordTextField.isEmpty else {
            errorMessage = Localizable.changePasswordEmptyFieldValidationText.value
            return false
        }
        
        if newPasswordTextField != confirmedNewPasswordTextField {
            errorMessage = Localizable.changePasswordCompatibilityValidationText.value
            return false
        }
        return true
    }
    
    func changePassword(_ successCompletion: @escaping () -> Void,
                        _ failureCompletion: @escaping () -> Void) {
        guard !currentPasswordTextField.isEmpty else {
            errorMessage = Localizable.changePasswordEmptyFieldValidationText.value
            failureCompletion()
            return
        }
        
        guard checkPasswordsCompatibility() else {
            failureCompletion()
            return
        }
        successCompletion()
    }
    
    private func clearErrorMessage() {
        errorMessage = .empty
    }
    
}
