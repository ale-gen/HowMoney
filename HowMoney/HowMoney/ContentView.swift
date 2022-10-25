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
    
    var body: some View {
        AppSwitcher(authService: AuthorizationService())
            .padding(.top, Constants.topPadding)
            .preferredColorScheme(Constants.preferredColorScheme)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
