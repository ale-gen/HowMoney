//
//  UserStateViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 27/10/2022.
//

import SwiftUI

class UserStateViewModel: ObservableObject {
    
    @AppStorage("isAuthorized") var isAuthorized: Bool = false
    @AppStorage("firstLogin") var firstLogin: Bool = true
    
    @Published var user: AuthUser? = nil {
        didSet {
            self.isResetPasswordEnabled = !(user?.id.contains("google") ?? true)
        }
    }
    @Published var localPreferenceCurrency: PreferenceCurrency = .usd
    @Published var localWeeklyReports: Bool = true
    @Published var localAlertsOnEmail: Bool = true
    
    private(set) var isResetPasswordEnabled: Bool
    private let authService: any Service
    private var task: Task<(), Never>?
    
    private var preferences: UserPreferences?
    
    init() {
        self.authService = Services.authService
        self.isResetPasswordEnabled = false
    }
    
    func login() {
        authService.login { [weak self] user in
            DispatchQueue.main.async {
                self?.user = user
                withAnimation(.easeOut) {
                    self?.isAuthorized.toggle()
                }
            }
        }
    }
    
    func logout() {
        authService.logout { [weak self] in
            LocalNotificationProvider.shared.disconnect()
            self?.user = nil
            withAnimation() {
                self?.isAuthorized.toggle()
            }
        }
    }
    
    @MainActor func getPreferences(_ failureCompletion: @escaping () -> Void) {
        task = Task {
            do {
                let result = try await authService.getData().first
                guard let result = result as? UserPreferences else {
                    revokeLocalPreferencesIfNeeded()
                    failureCompletion()
                    return
                }
                updateLocalPreferences(result)
            } catch let error {
                print("🆘 Error during fetching preferences for user: \(error.localizedDescription)")
                revokeLocalPreferencesIfNeeded()
                failureCompletion()
            }
        }
    }
    
    func updateLocalCurrencyPreference(_ preferenceCurrency: PreferenceCurrency,
                                       _ successCompletion: @escaping () -> Void,
                                       _ failureCompletion: @escaping () -> Void) {
        self.localPreferenceCurrency = preferenceCurrency
        DispatchQueue.main.async { [weak self] in
            self?.updatePreferences(successCompletion) {
                print("🆘 Failure on updating currency preference")
                failureCompletion()
            }
        }
    }
    
    func updateLocalWeeklyReports(_ weeklyReports: Bool,
                                  _ successCompletion: @escaping () -> Void,
                                  _ failureCompletion: @escaping () -> Void) {
        self.localWeeklyReports = weeklyReports
        DispatchQueue.main.async { [weak self] in
            self?.updatePreferences(successCompletion) {
                print("🆘 Failure on updating weekly reports")
                failureCompletion()
            }
        }
    }
    
    func updateLocalAlertsOnEmail(_ alertsOnEmail: Bool,
                                  _ successCompletion: @escaping () -> Void,
                                  _ failureCompletion: @escaping () -> Void) {
        self.localAlertsOnEmail = alertsOnEmail
        DispatchQueue.main.async { [weak self] in
            self?.updatePreferences(successCompletion) {
                print("🆘 Failure on updating alerts on email")
                failureCompletion()
            }
        }
    }
    
    func markPreferenceCustomizationAsShown() {
        guard firstLogin else { return }
        firstLogin.toggle()
    }
    
    @MainActor private func updatePreferences(_ successCompletion: @escaping () -> Void,
                                              _ failureCompletion: @escaping () -> Void) {
        task = Task {
            do {
                let result = try await authService.sendData(requestValues: .userPreferences(preferenceCurrency: localPreferenceCurrency.name.lowercased(),
                                                                                            weeklyReports: localWeeklyReports,
                                                                                            alertsOnEmail: localAlertsOnEmail))
                guard let result = result as? UserPreferences else {
                    revokeLocalPreferencesIfNeeded()
                    failureCompletion()
                    return
                }
                updateLocalPreferences(result)
                successCompletion()
            } catch let error {
                print("🆘 Error during user preferences updating: \(error.localizedDescription)")
                revokeLocalPreferencesIfNeeded()
                ToastViewModel.shared.update(message: Localizable.changeUserPreferencesFailureToastMessageText.value, type: .error)
                failureCompletion()
            }
        }
    }
    
    private func updateLocalPreferences(_ model: UserPreferences) {
        localPreferenceCurrency = model.preferenceCurrency
        localWeeklyReports = model.weeklyReports
        localAlertsOnEmail = model.alertsOnEmail
        preferences = UserPreferences(preferenceCurrency: localPreferenceCurrency,
                                      weeklyReports: localWeeklyReports,
                                      alertsOnEmail: localAlertsOnEmail)
    }
    
    private func revokeLocalPreferencesIfNeeded() {
        guard let preferences = preferences else { return }
        localPreferenceCurrency = preferences.preferenceCurrency
        localWeeklyReports = preferences.weeklyReports
        localAlertsOnEmail = preferences.alertsOnEmail
    }
    
}
