//
//  AppSwitcher.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 23/10/2022.
//

import SwiftUI

struct AppSwitcher: View {
    
    @StateObject var vm: UserStateViewModel = UserStateViewModel(authService: AuthorizationService())
    
    var body: some View {
        if vm.isAuthorized {
            UserCustomizationView()
                .environmentObject(vm)
                .transition(.opacity)
        } else {
            WelcomeView(didGetStarted: vm.login)
                .transition(.opacity)
        }
    }
}

struct AppSwitcher_Previews: PreviewProvider {
    
    static var previews: some View {
        AppSwitcher()
            .environmentObject(UserStateViewModel(authService: AuthorizationService()))
    }
}
