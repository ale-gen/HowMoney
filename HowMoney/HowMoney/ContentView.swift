//
//  ContentView.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 08/10/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var selection: TabBarItem = .home
    
    var body: some View {
        TabBarContent(selection: $selection) {
            UserAssetsCollection()
                .padding(.top, 200)
                .background(.gray)
                .tabBarItem(tab: .home, selection: $selection)
            Color("blackTwo")
                .tabBarItem(tab: .wallet, selection: $selection)
            Color("blackTwo")
                .tabBarItem(tab: .plus, selection: $selection)
            Color("blackTwo")
                .tabBarItem(tab: .transactions, selection: $selection)
            Color("blackTwo")
                .tabBarItem(tab: .profile, selection: $selection)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
