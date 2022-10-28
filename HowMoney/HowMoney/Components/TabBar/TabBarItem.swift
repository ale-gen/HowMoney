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
    
    var iconName: Image {
        switch self {
        case .home:
            return Icons.house.value
        case .wallet:
            return Icons.wallet.value
        case .plus:
            return Icons.plus.value
        case .transactions:
            return Icons.transactions.value
        case .profile:
            return Icons.profile.value
        }
    }
    
    var selectedIcon: Image {
        switch self {
        case .home:
            return Icons.selectedHouse.value
        case .wallet:
            return Icons.selectedWallet.value
        case .plus:
            return Icons.plus.value
        case .transactions:
            return Icons.selectedTransactions.value
        case .profile:
            return Icons.selectedProfile.value
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
                .fill(Color.lightBlue)
                .frame(width: 15.0, height: 5.0)
                .shadow(color: .lightBlue, radius: 4.0, x: .zero, y: 4))
        }
    }
    
    var backgroundShape: some View {
        switch self {
        case .plus:
            return AnyView(Circle()
                .fill(Color.lightBlue)
                .background(Circle()
                    .shadow(color: .gray, radius: 10.0, x: .zero, y: .zero)))
        default:
            return AnyView(EmptyView())
        }
    }
    
    func tabItemTapped(_ action: @escaping () -> Void) {
        action()
    }

}

struct TabBarItemView: View {
    
    private enum Constants {
        static let height: CGFloat = 60.0
        static let imageHeight: CGFloat = height / 2.6
        static let spacing: CGFloat = 8.0
        static let shadowRadius: CGFloat = 10.0
        static let rotationDegrees: CGFloat = 90.0
    }
    
    let tabItem: TabBarItem
    let selected: Bool
    @Binding var showCreationPopup: Bool
    
    var body: some View {
        VStack {
            ZStack {
                tabBarImage
                    .resizable()
                    .frame(width: Constants.imageHeight, height: Constants.imageHeight)
                    .font(.subheadline)
                    .rotationEffect(Angle(degrees: showCreationPopup && tabItem.shouldRotate ? Constants.rotationDegrees : .zero))
            }
            if selected {
                tabItem.selectionShape
            }
        }
        .foregroundColor(selected ? tabItem.selectedColor : tabItem.nonSelectedColor)
        .padding(.vertical, Constants.spacing)
        .frame(maxWidth: .infinity)
        .frame(height: Constants.height)
        .background(tabItem.backgroundShape)
    }
    
    private var tabBarImage: Image {
        return selected ? tabItem.selectedIcon : tabItem.iconName
    }
    
}

struct TabBarItemView_Previews: PreviewProvider {
    
    static var previews: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            TabBarItemView(tabItem: .plus, selected: true, showCreationPopup: .constant(false))
                .background(.black)
        }
    }
}
