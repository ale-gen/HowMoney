//
//  TabBarContent.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 08/10/2022.
//

import SwiftUI

struct TabBarContent<Content>: View where Content: View{
    
    @Binding private var selection: TabBarItem
    @State private var tabs: [TabBarItem] = []
    private let content: Content
    
    public init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content.ignoresSafeArea()
            TabBar(tabs: tabs, selection: $selection, localSelection: selection)
        }
        .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
            self.tabs = value
        }
    }
}

struct TabBarContent_Previews: PreviewProvider {
    
    static let tabBarItem: TabBarItem = .home
    
    static var previews: some View {
        TabBarContent(selection: .constant(tabBarItem)) {
            Text("Home")
        }
    }
}
