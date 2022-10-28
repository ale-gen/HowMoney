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
    @Published var preferenceCurrency: PreferenceCurrency = .usd
    private var authService: Service
    
    init(authService: Service) {
        self.authService = authService
    }
    
    func login() {
        authService.login { [weak self] user in
            self?.user = user
            self?.isAuthorized.toggle()
        }
    }
    
    func logout() {
        authService.logout { [weak self] in
            self?.user = nil
            self?.isAuthorized.toggle()
        }
    }
    
    func updateCurrencyPreference(_ preferenceCurrency: PreferenceCurrency) {
        self.preferenceCurrency = preferenceCurrency
    }
    
}