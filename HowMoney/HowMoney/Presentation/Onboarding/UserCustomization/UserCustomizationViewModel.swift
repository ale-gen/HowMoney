//
//  UserCustomizationViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 31/10/2022.
//

import SwiftUI

enum CustomizationStep: Int, CaseIterable {
    case preferenceCurrency = 1
    case emailAlert = 2
    case weeklyReports = 3
    
    var image: Image {
        switch self {
        case .preferenceCurrency:
            return Images.preferenceCurrencyIllustration.value
        case .emailAlert:
            return Images.alertsIllustration.value
        case .weeklyReports:
            return Images.weeklyReportsIllustration.value
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .preferenceCurrency, .emailAlert:
            return "Next"
        case .weeklyReports:
            return "Go to my wallet"
        }
    }
    
    var description: String {
        switch self {
        case .preferenceCurrency:
            return Localizable.onboardingUserCustomizationPreferenceCurrencyDescription.value
        case .emailAlert:
            return Localizable.onboardingUserCustomizationEmailAlertsDescription.value
        case .weeklyReports:
            return Localizable.onboardingUserCustomizationWeeklyReportsDescription.value
        }
    }
    
    var colorWordsDescription: [String] {
        switch self {
        case .preferenceCurrency:
            return ["1", "of", "3"]
        case .emailAlert:
            return ["notifications", "email", "alerts"]
        case .weeklyReports:
            return ["weekly", "reports,", "wallet", "balance."]
        }
    }
    
    var subtitle: String {
        switch self {
        case .preferenceCurrency:
            return .empty
        case .emailAlert:
            return "Send email alerts"
        case .weeklyReports:
            return "Send weekly reports"
        }
    }
}

class UserCustomizationViewModel: ObservableObject {
    
    @Published var presentStep: CustomizationStep = .preferenceCurrency
    
    @Published var chosenCurrency: PreferenceCurrency = .usd
    @Published var enabledEmailAlerts: Bool = true
    @Published var enabledWeeklyReports: Bool = true
    
    private var userStateVM: UserStateViewModel
    private var steps: [CustomizationStep] = [.preferenceCurrency, .emailAlert, .weeklyReports]
    
    init(userStateVM: UserStateViewModel) {
        self.userStateVM = userStateVM
    }
    
    func performNextStep(_ successCompletion: @escaping () -> Void,
                         _ failureCompletion: @escaping () -> Void) {
        setPreferenceValue({ [weak self] in
            guard let self = self else { return }
            let nextStepIndex = (self.steps.firstIndex(of: self.presentStep) ?? .zero) + .one
            if nextStepIndex == self.steps.count {
                successCompletion()
            } else {
                self.presentStep = self.steps[nextStepIndex]
            }
        }, {
            failureCompletion()
        })
        
    }
    
    func choosePreferenceCurrency(_ currency: PreferenceCurrency) {
        self.chosenCurrency = currency
    }
    
    func setPreferenceValue(_ successCompletion: @escaping () -> Void,
                            _ failureCompletion: @escaping () -> Void) {
        var onSuccess = successCompletion
        if presentStep == CustomizationStep.allCases.last {
            onSuccess = { [weak self] in
                self?.userStateVM.markPreferenceCustomizationAsShown()
                successCompletion()
            }
        }
        switch presentStep {
        case .preferenceCurrency:
            userStateVM.updateLocalCurrencyPreference(chosenCurrency, onSuccess, failureCompletion)
        case .emailAlert:
            userStateVM.updateLocalAlertsOnEmail(enabledEmailAlerts, onSuccess, failureCompletion)
        case .weeklyReports:
            userStateVM.updateLocalWeeklyReports(enabledWeeklyReports, onSuccess, failureCompletion)
        }
    }
    
}
