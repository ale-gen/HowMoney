//
//  UserAssetDetailsView.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 28/10/2022.
//

import SwiftUI

struct UserAssetDetailsView: View {
    
    private enum Constants {
        enum Origin {
            static let color: Color = .white.opacity(0.8)
            static let leadingInset: CGFloat = 20.0
        }
        enum Icon {
            static let height: CGFloat = 80.0
            static let shadow: CGFloat = 10.0
            static let shadowColor: Color = .white.opacity(0.3)
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
        enum Chart {
            static let contentPadding: CGFloat = 30.0
        }
        enum OperationOption {
            static let height: CGFloat = 100.0
            static let width: CGFloat = 100.0
            static let imageHeight: CGFloat = 30.0
            static let color: Color = .lightBlue
            static let opacity: CGFloat = 0.7
            static let fontColor: Color = .white
            static let cornerRadius: CGFloat = 15.0
            static let shadowRadius: CGFloat = 5.0
        }
        static let topOffset: CGFloat = 40.0
        static let verticalSpacing: CGFloat = 5.0
        static let horizontalSpacing: CGFloat = 10.0
    }
    
    @EnvironmentObject var authUserVM: UserStateViewModel
    @StateObject var vm: UserAssetViewModel
    
    @State private var preferenceCurrencyRequired: Bool = true
    @State private var showToast: Bool = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack(spacing: Constants.verticalSpacing) {
                    topBar
                    assetBasicInfo
                    assetValue
                    priceChangeLabel
                    actualExchangeRate
                    graph
                    operationOptions
                    Spacer()
                }
                .conditionalModifier(showToast, { $0.toast(shouldShow: $showToast, type: toastModel.type, message: toastModel.message)} )
                .padding(.top, Constants.topOffset)
                .padding(.bottom, geo.safeAreaInsets.bottom)
            }
            .navigationTitle(String.empty)
            .navigationBarHidden(true)
        }
        .onAppear {
            vm.fetchPriceHistory { vm.fetchPreferenceCurrencyPrice() }
        }
    }
    
    private var topBar: some View {
        HStack {
            Text(vm.userAsset.origin)
                .foregroundColor(Constants.Origin.color)
                .padding(.leading, Constants.Origin.leadingInset)
            Spacer()
            assetTypeSwitcher
        }
        .padding(.horizontal, Constants.horizontalSpacing)
    }
    
    private var assetTypeSwitcher: some View {
        CurrencySymbolToggleButton(isOn: $preferenceCurrencyRequired, canSwitch: vm.userAsset.asset.name == authUserVM.localPreferenceCurrency.name ? false : true, isOnImage: authUserVM.localPreferenceCurrency.symbol, isOffImage: vm.userAsset.asset.symbol ?? .empty)
        
    }
    
    private var assetBasicInfo: some View {
        VStack(spacing: Constants.verticalSpacing) {
            Image(vm.userAsset.asset.name.lowercased())
                .resizable()
                .scaledToFit()
                .frame(width: Constants.Icon.height, height: Constants.Icon.height)
                .shadow(color: Constants.Icon.shadowColor, radius: Constants.Icon.shadow)
                .padding(.bottom, Constants.Icon.bottomPadding)
            HStack(spacing: Constants.horizontalSpacing) {
                Text(vm.userAsset.asset.friendlyName)
                    .font(Constants.Title.font)
                    .foregroundColor(Constants.Title.color)
                Text(vm.userAsset.asset.name.uppercased())
                    .font(Constants.Subtitle.font)
                    .foregroundColor(Constants.Subtitle.color)
            }
        }
    }
    
    private var assetValue: some View {
        HStack(spacing: Constants.horizontalSpacing) {
            AssetValueLabel(value: preferenceCurrencyRequired ? vm.userAsset.preferenceCurrencyValue : vm.userAsset.originValue,
                            symbol: preferenceCurrencyRequired ? authUserVM.localPreferenceCurrency.symbol : vm.userAsset.asset.symbol ?? .empty,
                            type: preferenceCurrencyRequired ? .currency : vm.userAsset.asset.type)
            .font(Constants.MainValue.font)
            .foregroundColor(Constants.MainValue.color)
        }
    }
    
    private var priceChangeLabel: some View {
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
    
    private var actualExchangeRate: some View {
        Text("\(Localizable.userAssetDetailsCurrentExchangeRate.value) \(vm.actualExchangeRate, specifier: "%.2f")\(vm.preferenceCurrencySymbol ?? .empty)")
    }
    
    private var graph: some View {
        LineChart(data: vm.userAssetPriceHistory)
            .padding(.vertical, Constants.Chart.contentPadding)
    }
    
    private var operationOptions: some View {
        HStack {
            Spacer()
            operationOption(type: .update)
            Spacer()
            operationOption(type: .add)
            Spacer()
            operationOption(type: .substract)
            Spacer()
        }
    }
    
    private var toastModel: ToastModel {
        vm.getToastValues()!
    }

    private func operationOption(type: UserAssetOperation) -> some View {
        NavigationLink {
            UserAssetEditingView(vm: vm.prepareEditingViewModel(type), showToast: $showToast)
        } label: {
            RoundedRectangle(cornerRadius: Constants.OperationOption.cornerRadius)
                .foregroundColor(Constants.OperationOption.color)
                .shadow(color: Constants.OperationOption.color, radius: Constants.OperationOption.shadowRadius)
                .opacity(Constants.OperationOption.opacity)
                .frame(width: Constants.OperationOption.width, height: Constants.OperationOption.height)
                .overlay(VStack(spacing: Constants.verticalSpacing) {
                    type.icon
                        .resizable()
                        .scaledToFit()
                        .frame(height: Constants.OperationOption.imageHeight)
                    Text(type.title)
                }.foregroundColor(Constants.OperationOption.fontColor))
        }
    }
}

struct UserAssetDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserAssetDetailsView(vm: UserAssetViewModel(userAsset: UserAsset.UserAssetsMock.first!, preferenceCurrency: .usd))
            .background(.black)
            .environmentObject(UserStateViewModel())
    }
}

struct UserAssetDetailsViewSmallerDevices_Previews: PreviewProvider {
    static var previews: some View {
        UserAssetDetailsView(vm: UserAssetViewModel(userAsset: UserAsset.UserAssetsMock.first!, preferenceCurrency: .usd))
            .background(.black)
            .environmentObject(UserStateViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
    }
}
