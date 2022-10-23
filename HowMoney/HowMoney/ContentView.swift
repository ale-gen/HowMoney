//
//  ContentView.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 08/10/2022.
//

import SwiftUI
import Auth0

struct ContentView: View {
    
    var body: some View {
        AppSwitcher(authService: AuthorizationService())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
