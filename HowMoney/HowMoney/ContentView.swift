//
//  ContentView.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 08/10/2022.
//

import SwiftUI
import Auth0

struct ContentView: View {
    
    private enum Constants {
        static let topPadding: CGFloat = 1.0
        static let preferredColorScheme: ColorScheme = .dark
    }
    
    @Environment(\.scenePhase) var scenePhase
    @AppStorage("isAuthorized") var isAuthorized: Bool = false
    
    var body: some View {
        AppSwitcher()
            .padding(.top, Constants.topPadding)
            .preferredColorScheme(Constants.preferredColorScheme)
            .onChange(of: scenePhase) { _ in
                switch scenePhase {
                case .active:
                    UIApplication.shared.applicationIconBadgeNumber = .zero
                case .inactive:
                    isAuthorized = false
                default:
                    break
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
