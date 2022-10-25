//
//  TabBarItemModifier.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 08/10/2022.
//

import SwiftUI

struct TabBarItemModifier: ViewModifier {
    
    private enum Constants {
        static let backgroundColor: Color = .black
        static let bottomOffset: CGFloat = -80.0
    }
    
    @Binding var selection: TabBarItem
    let tab: TabBarItem
    
    func body(content: Content) -> some View {
        content
            .background(Constants.backgroundColor)
            .padding(.bottom, Constants.bottomOffset)
            .opacity(selection == tab ? 1.0 : 0.0)
            .preference(key: TabBarItemsPreferenceKey.self, value: [tab])
    }
}

extension View {
    
    func tabBarItem(tab: TabBarItem, selection: Binding<TabBarItem>) -> some View {
        self.modifier(TabBarItemModifier(selection: selection, tab: tab))
    }
    
}
