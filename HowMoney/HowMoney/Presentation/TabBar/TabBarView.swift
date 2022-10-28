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

class TabBarContentViewRouter: ObservableObject {
    
    enum TabBarContent {
        case home
        case wallet
        case transactions
        case profile
        
        var contentView: AnyView {
            switch self {
            case .home:
                return AnyView(HomeTabBarItem())
            case .wallet:
                return AnyView(UserAssetsTabBarItem(searchText: .constant(.empty)))
            case .transactions:
                return AnyView(TransactionsTabBarItem())
            case .profile:
                return AnyView(ProfileTabBarItem())
            }
        }
    }
     
    @Published var currentContent: AnyView = TabBarContent.home.contentView
    
    func navigateToContent(_ selectedTabBar: TabBarItem) {
        guard selectedTabBar != .plus else { return }
        switch selectedTabBar {
        case .home:
            currentContent = TabBarContent.home.contentView
        case .wallet:
            currentContent = TabBarContent.wallet.contentView
        case .transactions:
            currentContent = TabBarContent.transactions.contentView
        case .profile:
            currentContent = TabBarContent.profile.contentView
        default:
            break
        }
    }
    
 }

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
            .environmentObject(UserStateViewModel(authService: AuthorizationService()))
    }
}
