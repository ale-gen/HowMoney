//
//  ContentView.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 08/10/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var selection: TabBarItem = .home
    @State var searchText: String = ""
    
    var body: some View {
        TabBarContent(selection: $selection) {
            HomeTabBarItem()
                .tabBarItem(tab: .home, selection: $selection)
                .padding(.bottom, 80)
            UserAssetsTabBarItem(searchText: $searchText)
                .padding(.bottom, 80)
                .tabBarItem(tab: .wallet, selection: $selection)
            Color.red
                .tabBarItem(tab: .plus, selection: $selection)
            Color.blue
                .tabBarItem(tab: .transactions, selection: $selection)
            Color.orange
                .tabBarItem(tab: .profile, selection: $selection)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
