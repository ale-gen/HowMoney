//
//  AppSwitcher.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 23/10/2022.
//

import SwiftUI

struct AppSwitcher: View {
    
    @State private var isAuthorized: Bool = false
    private var authService: Service
    
    init(authService: Service) {
        self.authService = authService
    }
    
    var body: some View {
        if isAuthorized {
            TabBarView(onLogoutButtonTapped: endSession)
        } else {
            WelcomeView(didGetStarted: startSession)
        }
    }
    
    private func startSession() {
        authService.login {
            isAuthorized.toggle()
        }
    }
    
    private func endSession() {
        authService.logout {
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
