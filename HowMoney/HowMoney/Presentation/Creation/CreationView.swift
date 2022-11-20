//
//  CreationView.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 15/11/2022.
//

import SwiftUI

struct CreationView: View {
    
    private enum Constants {
        static let spacing: CGFloat = 20.0
        
        enum SelectionButton {
            static let cornerRadius: CGFloat = 10.0
            static let color: Color = .lightBlue.opacity(0.6)
            static let shadowColor: Color = .lightBlue
            static let height: CGFloat = 60.0
            static let textColor: Color = .white
        }
        enum Icon {
            static let color: Color = .white
        }
        enum AssetInfo {
            static let horizontalPadding: CGFloat = 30.0
            static let titleColor: Color = .white
            static let subtitleColor: Color = .white.opacity(0.7)
        }
        enum ValueLabel {
            static let maxHeight: CGFloat = 150.0
            static let font: Font = .system(size: 40.0)
            static let color: Color = .white
            static let defaultValue: String = .zero
        }
        enum Keyboard {
            static let maxHeight: CGFloat = 300.0
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm: CreationViewModel
    
    @StateObject private var toastVM: ToastViewModel = ToastViewModel.shared
    @State private var textValue: String = Constants.ValueLabel.defaultValue
    
    var body: some View {
        VStack {
            if vm.context == .alert {
                currencyPicker
            }
            
            NavigationLink(destination: AssetsCollection(assetVM: vm.prepareAssetsCollectionViewModel())) {
                RoundedRectangle(cornerRadius: Constants.SelectionButton.cornerRadius)
                    .fill(Constants.SelectionButton.color)
                    .frame(height: Constants.SelectionButton.height)
                    .shadow(color: Constants.SelectionButton.shadowColor, radius: Constants.SelectionButton.cornerRadius)
                    .overlay {
                        HStack {
                            if let asset = vm.selectedAsset {
                                selectedAssetInfo(asset)
                            } else {
                                assetSelectionButton
                            }
                            Spacer()
                            Icons.rightArrow.value
                                .foregroundColor(Constants.Icon.color)
                        }
                        .padding(.horizontal, Constants.AssetInfo.horizontalPadding)
                    }
                    .padding(.horizontal)
            }
            .padding(.top, Constants.spacing)
            
            Spacer()
            valueLabel
            Spacer()
            
            RectangleButton(title: Localizable.userAssetsCreationAddToMyWalletButtonTitle.value, didButtonTapped: sendForm)
                .padding(.bottom, Constants.spacing)
            
            KeyboardView(vm: vm.prepareKeyboardViewModel(), textValue: $textValue)
                .frame(maxHeight: Constants.Keyboard.maxHeight)
        }
        .toast(shouldShow: $toastVM.isShowing, type: toastVM.toast.type, message: toastVM.toast.message)
        .transition(.move(edge: .bottom))
    }
    
    private var assetSelectionButton: some View {
        Text(Localizable.userAssetsCreationSelectionPromptText.value)
            .foregroundColor(Constants.SelectionButton.textColor)
    }
    
    private func selectedAssetInfo(_ asset: Asset) -> some View {
        AssetInfoView(asset: asset,
                      titleColor: Constants.AssetInfo.titleColor,
                      subtitleColor: Constants.AssetInfo.subtitleColor)
    }
    
    private var currencyPicker: some View {
        VStack {
            Text(Localizable.alertsCreationTargetCurrencyText.value)
            if let vm = vm as? AlertCreationViewModel {
                SegmentedPickerView(items: PreferenceCurrency.allCases.map { $0.name }, didSelectItem: vm.updateTargetCurrency)
            }
        }
    }
    
    private var valueLabel: some View {
        ZStack {
            // TODO: Ensure typing correct number of decimal places depends on chosen asset type
            HStack {
                Spacer()
                Text(textValue)
                Text(vm.selectedAsset?.symbol ?? .empty)
                Spacer()
            }
            .foregroundColor(Constants.ValueLabel.color)
            .font(Constants.ValueLabel.font)
        }
    }
    
    private func sendForm() {
        vm.create(successCompletion: {
            print("Success 🥳")
            ToastViewModel.shared.show()
            DispatchQueue.main.async {
                presentationMode.wrappedValue.dismiss()
            }
        }, failureCompletion: {
            print("Failure 🫠")
            ToastViewModel.shared.show()
        })
    }
}

struct CreationView_Previews: PreviewProvider {
    static var previews: some View {
        CreationView(vm: AlertCreationViewModel(service: AlertService()))
    }
}
