//
//  UserAssetDetailsView.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 28/10/2022.
//

import SwiftUI

struct UserAssetDetailsView: View {
    
    private enum Constants {
        enum Icon {
            static let height: CGFloat = 80.0
            static let shadow: CGFloat = 10.0
            static let bottomPadding: CGFloat = 20.0
        }
        enum Title {
            static let font: Font = .system(size: 25.0, weight: .light)
            static let color: Color = .white
        }
        enum Subtitle {
            static let font: Font = .system(size: 17.0, weight: .light)
            static let color: Color = .gray
        }
        enum MainValue {
            static let color: Color = .white
            static let font: Font = .system(size: 40.0, weight: .bold)
        }
        enum SubValue {
            static let color: Color = .black
            static let font: Font = .system(size: 15.0, weight: .light)
            static let spacing: CGFloat = 2.0
            static let innerContainerHorizontalInset: CGFloat = -20.0
        }
        enum Rectangle {
            static let cornerRadius: CGFloat = 20.0
            static let color: Color = .white
        }
        enum PriceChangeLabel {
            static let backgroundColor: Color = .black
            static let font: Font = SubValue.font
            static let color: Color = SubValue.color
            static let cornerRadius: CGFloat = 10.0
            static let opacity: CGFloat = 0.25
            static let width: CGFloat = 100.0
            static let height: CGFloat = 30.0
            static let padding: CGFloat = 20.0
        }
        static let verticalSpacing: CGFloat = 5.0
        static let horizontalSpacing: CGFloat = 10.0
    }
    
    @EnvironmentObject var authUserVM: UserStateViewModel
    @StateObject var vm: UserAssetViewModel
    @State private var preferenceCurrencyRequired: Bool = true
    
    var body: some View {
        ZStack {
            VStack(spacing: Constants.verticalSpacing) {
                assetTypeSwitcher
                assetBasicInfo
                assetValue
                priceChangeLabel
                Spacer()
            }
            graph
        }
    }
    
    private var assetTypeSwitcher: some View {
        HStack {
            Spacer()
            CurrencySymbolToggleButton(isOn: $preferenceCurrencyRequired, isOnImage: authUserVM.preferenceCurrency.symbol, isOffImage: vm.userAsset.asset.symbol ?? .empty)
        }
    }
    
    private var assetBasicInfo: some View {
        VStack(spacing: Constants.verticalSpacing) {
            // TODO: asset image/symbol/flag
            Image("bitcoin")
                .resizable()
                .scaledToFit()
                .frame(width: Constants.Icon.height, height: Constants.Icon.height)
                .shadow(color: .orange, radius: Constants.Icon.shadow)
                .padding(.bottom, Constants.Icon.bottomPadding)
            HStack(spacing: Constants.horizontalSpacing) {
                Text(vm.userAsset.asset.friendlyName)
                    .font(Constants.Title.font)
                    .foregroundColor(Constants.Title.color)
                Text(vm.userAsset.asset.name)
                    .font(Constants.Subtitle.font)
                    .foregroundColor(Constants.Subtitle.color)
            }
        }
    }
    
    private var assetValue: some View {
        HStack(spacing: Constants.horizontalSpacing) {
            AssetValueLabel(value: preferenceCurrencyRequired ? vm.userAsset.preferenceCurrencyValue : vm.userAsset.originValue,
                            symbol: preferenceCurrencyRequired ? authUserVM.preferenceCurrency.symbol : vm.userAsset.asset.symbol ?? .empty,
                            type: preferenceCurrencyRequired ? .currency : vm.userAsset.asset.type)
                .font(Constants.MainValue.font)
                .foregroundColor(Constants.MainValue.color)
        }
    }
    
    private var priceChangeLabel: some View {
        ZStack {
            HStack {
                vm.assetPriceChangeImage
                Text("\(vm.assetPricePercentageChangeValue, specifier: "%.2f")\(.percentage)")
                Text(Localizable.userAssetDetailsPriceUpdateTime.value)
            }
            .foregroundColor(vm.priceChangeColor)
            .padding(Constants.PriceChangeLabel.padding)
            .overlay(RoundedRectangle(cornerRadius: Constants.PriceChangeLabel.cornerRadius)
                    .frame(height: Constants.PriceChangeLabel.height)
                    .foregroundColor(vm.priceChangeColor)
                    .opacity(Constants.PriceChangeLabel.opacity))
        }
    }
    
    private var graph: some View {
        VStack {
            Spacer()
            LineChart(data: vm.userAssetPriceHistory)
            Spacer()
        }
    }
}

struct UserAssetDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserAssetDetailsView(vm: UserAssetViewModel(userAsset: UserAsset.UserAssetsMock.first!))
            .background(.black)
            .environmentObject(UserStateViewModel(authService: AuthorizationService()))
    }
}
