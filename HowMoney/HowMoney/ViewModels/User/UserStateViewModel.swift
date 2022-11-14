//
//  UserStateViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 27/10/2022.
//

import SwiftUI

class UserStateViewModel: ObservableObject {
    
    @Published var isAuthorized: Bool = false
    @Published var user: AuthUser? = nil
    @Published var localPreferenceCurrency: PreferenceCurrency = .usd
    @Published var localWeeklyReports: Bool = true
    @Published var localAlertsOnEmail: Bool = true
    
    private let authService: any Service
    private var task: Task<(), Never>?
    
    private var preferences: UserPreferences?
    
    init() {
        self.authService = Services.authService
    }
    
    func login() {
        authService.login { [weak self] user in
            self?.user = user
            withAnimation(.easeOut) {
                self?.isAuthorized.toggle()
            }
        }
    }
    
    func logout() {
        authService.logout { [weak self] in
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
    
    func updateLocalCurrencyPreference(_ preferenceCurrency: PreferenceCurrency) {
        self.localPreferenceCurrency = preferenceCurrency
        DispatchQueue.main.async { [weak self] in
            self?.updatePreferences {
                print("🆘 Failure on updating currency preference")
            }
        }
    }
    
    func updateLocalWeeklyReports(_ weeklyReports: Bool) {
        self.localWeeklyReports = weeklyReports
        DispatchQueue.main.async { [weak self] in
            self?.updatePreferences {
                print("🆘 Failure on updating weekly reports")
            }
        }
    }
    
    func updateLocalAlertsOnEmail(_ alertsOnEmail: Bool) {
        self.localAlertsOnEmail = alertsOnEmail
        DispatchQueue.main.async { [weak self] in
            self?.updatePreferences {
                print("🆘 Failure on updating alerts on email")
            }
        }
    }
    
    @MainActor private func updatePreferences(_ failureCompletion: @escaping () -> Void) {
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
            } catch let error {
                print("🆘 Error during user preferences updating: \(error.localizedDescription)")
                revokeLocalPreferencesIfNeeded()
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
