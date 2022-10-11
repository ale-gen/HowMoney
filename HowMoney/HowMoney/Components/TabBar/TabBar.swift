//
//  TabBar.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 08/10/2022.
//

import SwiftUI

struct TabBar: View {
    
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    @Namespace private var namespace
    @State var localSelection: TabBarItem
    @State var showCreationPopup: Bool = true
    
    var body: some View {
        ZStack {
            if showCreationPopup {
                plusMenu
                    .offset(y: -80)
            }
            tabBar
                .onChange(of: selection) { newValue in
                    withAnimation {
                        localSelection = newValue
                    }
                }
        }
    }
    
    private func switchToTab(tab: TabBarItem) {
        selection = tab
    }
}

struct TabBar_Previews: PreviewProvider {
    
    static let tabs: [TabBarItem] = [.home, .wallet, .plus, .transactions, .profile]
    
    static var previews: some View {
        TabBar(tabs: tabs, selection: .constant(.home), localSelection: .home)
    }
}

extension TabBar {
    
    private var tabBar: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                TabBarItemView(tabItem: tab, selected: localSelection == tab)
                    .onTapGesture {
                        tab.tabItemTapped {
                            switchToTab(tab: tab)
                            withAnimation {
                                guard selection == .plus else { showCreationPopup = false
                                    return
                                }
                                showCreationPopup.toggle()
                            }
                        }
                    }
            }
        }
        .padding(6)
        .background(Color("blackTwo").ignoresSafeArea(edges: .bottom))
    }
    
    private var plusMenu: some View {
        HStack(spacing: 40) {
            plusMenuItem("dollarsign")
            plusMenuItem("bell")
        }
        .transition(.scale)
    }
    
    private func plusMenuItem(_ item: String) -> some View {
        ZStack {
            Circle()
                .foregroundColor(Color("lightPurple"))
                .frame(width: 50, height: 50)
                .shadow(color: Color("lightPurpleTwo"), radius: 3.0, x: 0, y: 0)
            Image(systemName: item)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(15)
                .frame(width: 50, height: 50)
                .foregroundColor(.white)
        }
    }
    
}
