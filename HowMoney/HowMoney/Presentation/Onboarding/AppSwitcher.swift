//
//  AppSwitcher.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 23/10/2022.
//

import SwiftUI

struct AppSwitcher: View {
    
    @State private var isAuthorized: Bool = false
    @State private var user: AuthUser? = nil
    private var authService: Service
    
    init(authService: Service) {
        self.authService = authService
    }
    
    var body: some View {
        if isAuthorized {
            TabBarView(user: $user, onLogoutButtonTapped: endSession)
        } else {
            WelcomeView(didGetStarted: startSession)
        }
    }
    
    private func startSession() {
        authService.login { user in
            self.user = user
            isAuthorized.toggle()
        }
    }
    
    private func endSession() {
        authService.logout {
            self.user = nil
            isAuthorized.toggle()
        }
    }
}

struct AppSwitcher_Previews: PreviewProvider {
    
    static let authService: Service = AuthorizationService()
    
    static var previews: some View {
        AppSwitcher(authService: authService)
    }
}
