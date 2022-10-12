//
//  TabBarItem.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 08/10/2022.
//

import SwiftUI

enum TabBarItem: Hashable {
    case home
    case wallet
    case plus
    case transactions
    case profile
    
    var iconName: String {
        switch self {
        case .home:
            return "house"
        case .wallet:
            return "dollarsign.circle"
        case .plus:
            return "plus"
        case .transactions:
            return "clock"
        case .profile:
            return "person"
        }
    }
    
    var selectedIcon: String {
        switch self {
        case .home:
            return "house.fill"
        case .wallet:
            return "dollarsign.circle.fill"
        case .plus:
            return "plus"
        case .transactions:
            return "clock.fill"
        case .profile:
            return "person.fill"
        }
    }
    
    var selectedColor: Color {
        return .white
    }
    
    var nonSelectedColor: Color {
        switch self {
        case .plus:
            return .white
        default:
            return .gray
        }
    }
    
    var shouldRotate: Bool {
        switch self {
        case .plus:
            return true
        default:
            return false
        }
    }
    
    var selectionShape: some View {
        switch self {
        case .plus:
            return AnyView(EmptyView())
        default:
            return AnyView(RoundedRectangle(cornerRadius: 10)
                .fill(Color("lightPurple"))
                .frame(width: 15.0, height: 5.0)
                .shadow(color: Color("lightPurpleTwo"), radius: 4.0, x: 0, y: 4))
        }
    }
    
    var backgroundShape: some View {
        switch self {
        case .plus:
            return AnyView(Circle()
                .strokeBorder(Color("lightPurpleTwo"), lineWidth: 59.9)
                .background(Circle().fill(Color("lightPurple"))))
        default:
            return AnyView(EmptyView())
        }
    }
    
    func tabItemTapped(_ action: @escaping () -> Void) {
        action()
    }

}

struct TabBarItemView: View {
    
    let tabItem: TabBarItem
    var selected: Bool
    @Namespace private var namespace
    
    var body: some View {
        VStack {
            ZStack {
                tabItem.backgroundShape
                    .shadow(radius: 10)
                Image(systemName: selected ? tabItem.selectedIcon : tabItem.iconName)
                    .font(.subheadline)
                    .rotationEffect(Angle(degrees: selected && tabItem.shouldRotate ? 90.0 : 0.0))
            }
            if selected {
                tabItem.selectionShape
            }
        }
        .foregroundColor(selected ? tabItem.selectedColor : tabItem.nonSelectedColor)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .frame(height: 60.0)
        .background(tabItem.backgroundShape)
    }
    
}

struct TabBarItemView_Previews: PreviewProvider {
    
    static var previews: some View {
        TabBarItemView(tabItem: .plus, selected: true)
            .background(.black)
    }
}
