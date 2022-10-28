//
//  UserAssetTabBar.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 18/10/2022.
//

import SwiftUI

enum AssetFilter: CaseIterable {
    case all
    case currencies
    case cryptos
    case metals
    
    var name: String {
        switch self {
        case .all:
            return Localizable.assetsAllTypesText.value
        case .currencies:
            return Localizable.assetsCurrencyTypeName.value
        case .cryptos:
            return Localizable.assetsCryptocurrencyTypeName.value
        case .metals:
            return Localizable.assetsMetalTypeName.value
        }
    }
    
    var possibleAssetTypes: [AssetType] {
        switch self {
        case .all:
            return [.currency, .cryptocurrency, .metal]
        case .currencies:
            return [.currency]
        case .cryptos:
            return [.cryptocurrency]
        case .metals:
            return [.metal]
        }
    }
}

struct UserAssetsTabBarItem: View {
    
    private enum Constants {
        enum Filter {
            static let verticalInsets: CGFloat = 30.0
            static let horizontalInsets: CGFloat = 20.0
            static let spacing: CGFloat = 7.0
            static let textColor: Color = .white
            static let textPadding: CGFloat = 10.0
            static let selectedColor: Color = .lightBlue
            static let nonSelectedColor: Color = .lightBlue.opacity(0.4)
            static let backgroundCornerRadius: CGFloat = 10.0
            static let backgroundShadowColor: Color = .lightBlue.opacity(0.7)
            static let backgroundShadowRadius: CGFloat = 15.0
        }
    }
    
    @Binding var searchText: String
    @StateObject var vm: UserAssetViewModel = UserAssetViewModel()
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                filterAssetTypePicker
                
                UserAssetsCollection(userAssets: vm.filteredUserAssets)
                    .transition(.opacity)
            }
            .searchable(text: $searchText)
        }
    }
    
    private var filterAssetTypePicker: some View {
        return HStack(alignment: .center, spacing: Constants.Filter.spacing) {
            Spacer()
            ForEach(AssetFilter.allCases, id: \.self) { type in
                Button {
                    withAnimation {
                        vm.selectedFilter = type
                    }
                } label: {
                    Text(type.name)
                        .padding(Constants.Filter.textPadding)
                        .foregroundColor(Constants.Filter.textColor)
                        .background(RoundedRectangle(cornerRadius: Constants.Filter.backgroundCornerRadius)
                            .fill(vm.selectedFilter == type ? Constants.Filter.selectedColor : Constants.Filter.nonSelectedColor)
                            .shadow(color: Constants.Filter.backgroundShadowColor , radius: vm.selectedFilter == type ? Constants.Filter.backgroundShadowRadius: .zero))
                }
            }
            Spacer()
        }
        .padding(.vertical, Constants.Filter.verticalInsets)
    }
}

struct UserAssetTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            UserAssetsTabBarItem(searchText: .constant(""))
        }
    }
}
