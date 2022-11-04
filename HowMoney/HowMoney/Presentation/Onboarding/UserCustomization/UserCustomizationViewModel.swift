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
    
    private var steps: [CustomizationStep] = [.preferenceCurrency, .emailAlert, .weeklyReports]
    
    func performNextStep(_ successCompletion: @escaping () -> Void) {
        let nextStepIndex = (steps.firstIndex(of: presentStep) ?? .zero) + 1
        if nextStepIndex == steps.count {
            // Navigate to HomeTabBar()
            successCompletion()
        } else {
            // Navigate to next onboarding screen
            withAnimation(.linear(duration: 0.4)) {
                presentStep = steps[nextStepIndex]
            }
        }
    }
    
    func choosePreferenceCurrency(_ currency: PreferenceCurrency) {
        self.chosenCurrency = currency
    }
    
}
