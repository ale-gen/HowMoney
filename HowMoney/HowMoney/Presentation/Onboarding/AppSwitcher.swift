//
//  AppSwitcher.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 23/10/2022.
//

import SwiftUI

struct AppSwitcher: View {
    
    @StateObject var vm: UserStateViewModel = UserStateViewModel()
    @State private var showLaunchScreen: Bool = true
    
    var body: some View {
        ZStack {
            if vm.isAuthorized && vm.firstLogin {
                UserCustomizationView(vm: UserCustomizationViewModel(userStateVM: vm), showLaunchScreen: $showLaunchScreen)
                    .environmentObject(vm)
            } else if vm.isAuthorized {
                TabBarView(showLaunchScreen: $showLaunchScreen)
                    .environmentObject(vm)
            } else {
                WelcomeView(didGetStarted: vm.login)
                    .transition(.opacity)
            }
            
            if showLaunchScreen {
                LaunchView(showLaunchScreen: $showLaunchScreen)
                    .transition(.opacity)
            }
        }
        .onChange(of: vm.isAuthorized) { newValue in
            if newValue {
                showLaunchScreen = true
            }
        }
    }
}

struct AppSwitcher_Previews: PreviewProvider {
    
    static var previews: some View {
        AppSwitcher()
            .environmentObject(UserStateViewModel())
    }
}
