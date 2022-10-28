//
//  TabBarView.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 23/10/2022.
//

import SwiftUI

struct TabBarView: View {
    
    @EnvironmentObject var userState: UserStateViewModel
    @State var selection: TabBarItem = .home
    @State var searchText: String = ""
    
    var body: some View {
        TabBarContent(selection: $selection) {
            HomeTabBarItem()
                .tabBarItem(tab: .home, selection: $selection)
            UserAssetsTabBarItem(searchText: $searchText)
                .tabBarItem(tab: .wallet, selection: $selection)
            Color.black.ignoresSafeArea()
                .tabBarItem(tab: .plus, selection: $selection)
            TransactionsTabBarItem()
                .tabBarItem(tab: .transactions, selection: $selection)
            ProfileTabBarItem()
                .tabBarItem(tab: .profile, selection: $selection)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
            .environmentObject(UserStateViewModel(authService: AuthorizationService()))
    }
}
