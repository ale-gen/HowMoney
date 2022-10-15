//
//  TabBar.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 08/10/2022.
//

import SwiftUI

struct TabBar: View {
    
    private enum Constants {
        enum General {
            static let backgroundColor: Color = Color("blackTwo")
            static let padding: CGFloat = 10.0
        }
        enum PlusMenu {
            static let spacing: CGFloat = 40.0
            static let offset: CGFloat = -80.0
            enum Button {
                static let height: CGFloat = 50.0
                static let color: Color = Color("lightPurple")
                static let shadowColor: Color = Color("lightPurpleTwo")
                static let shadowRadius: CGFloat = 3.0
                static let padding: CGFloat = 15.0
                static let fontColor: Color = .white
            }
        }
    }
    
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    @State var localSelection: TabBarItem
    @State var showCreationPopup: Bool = false
    
    var body: some View {
        ZStack {
            if showCreationPopup {
                plusMenu
                    .offset(y: Constants.PlusMenu.offset)
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

extension TabBar {
    
    private var tabBar: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                TabBarItemView(tabItem: tab, selected: localSelection == tab, showCreationPopup: $showCreationPopup)
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
        .padding(Constants.General.padding)
        .background(Constants.General.backgroundColor)
        .ignoresSafeArea(edges: .bottom)
    }
    
    private var plusMenu: some View {
        HStack(spacing: Constants.PlusMenu.spacing) {
            plusMenuItem(Icons.dollarSign.value)
            plusMenuItem(Icons.bell.value)
        }
        .transition(.scale)
    }
    
    private func plusMenuItem(_ item: Image) -> some View {
        ZStack {
            Circle()
                .foregroundColor(Constants.PlusMenu.Button.color)
                .frame(width: Constants.PlusMenu.Button.height, height: Constants.PlusMenu.Button.height)
                .shadow(color: Constants.PlusMenu.Button.shadowColor, radius: Constants.PlusMenu.Button.shadowRadius, x: .zero, y: .zero)
            item
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(Constants.PlusMenu.Button.padding)
                .frame(width: Constants.PlusMenu.Button.height, height: Constants.PlusMenu.Button.height)
                .foregroundColor(Constants.PlusMenu.Button.fontColor)
        }
    }
    
}

struct TabBar_Previews: PreviewProvider {
    
    static let tabs: [TabBarItem] = [.home, .wallet, .plus, .transactions, .profile]
    
    static var previews: some View {
        TabBar(tabs: tabs, selection: .constant(.home), localSelection: .home)
    }
}
