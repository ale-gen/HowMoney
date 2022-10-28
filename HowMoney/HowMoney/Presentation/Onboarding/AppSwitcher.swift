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
            TabBarView()
                .environmentObject(vm)
        } else {
            WelcomeView(didGetStarted: vm.login)
        }
    }
}

struct AppSwitcher_Previews: PreviewProvider {
    
    static var previews: some View {
        AppSwitcher()
    }
}
