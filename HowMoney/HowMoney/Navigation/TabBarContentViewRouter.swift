//
//  TabBarContentViewRouter.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 28/10/2022.
//

import SwiftUI

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
