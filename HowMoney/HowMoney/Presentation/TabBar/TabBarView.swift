//
//  TabBarView.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 23/10/2022.
//

import SwiftUI

struct TabBarView: View {
    
    @EnvironmentObject var userState: UserStateViewModel
    @StateObject var contentViewRouter: TabBarContentViewRouter = TabBarContentViewRouter()
    @State var selection: TabBarItem = .home
    @State var searchText: String = ""
    
    var body: some View {
        ZStack {
            contentViewRouter.currentContent
            VStack {
                Spacer()
                TabBar(tabs: [.home, .wallet, .plus, .transactions, .profile], selection: $selection, localSelection: selection)
            }
        }
        .onChange(of: selection) { newValue in
            contentViewRouter.navigateToContent(newValue)
        }
        
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
            .environmentObject(UserStateViewModel(authService: AuthorizationService()))
    }
}
