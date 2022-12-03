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
        enum Animation {
            static let delay: CGFloat = 0.2
        }
    }

    @StateObject var vm: UserAssetsListViewModel = UserAssetsListViewModel(service: Services.userAssetService)
    @State var selectedFilter: AssetFilter = .all
    @Binding var searchText: String
    
    @State private var loaderView: LoaderView? = LoaderView()
    @State private var loading: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                filterAssetTypePicker
                
                let filteredItems = vm.userAssets.filter { selectedFilter.possibleAssetTypes.contains($0.key.type) }
                UserAssetsCollectionByAsset(items: filteredItems, didUserAssetDeleted: vm.deleteUserAsset)
                    .transition(.opacity)
            }
        }
        .loader(loader: $loaderView, shouldHideLoader: $loading)
        .onAppear {
            vm.getUserAssets {
                DispatchQueue.main.asyncAfter(deadline: .now() + Constants.Animation.delay) {
                    loading.toggle()
                }
            }
        }
    }
    
    private var filterAssetTypePicker: some View {
        SegmentedPickerView(items: AssetFilter.allCases.map { $0.name },
                            didSelectItem: didFilterTapped,
                            font: .footnote,
                            fontWeight: .medium)
    }
    
    private func didFilterTapped(_ index: Int) {
        selectedFilter = AssetFilter.allCases[index]
    }
}

struct UserAssetTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            UserAssetsTabBarItem(searchText: .constant(""))
        }
        .environmentObject(UserStateViewModel())
    }
}
