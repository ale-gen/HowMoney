//
//  CreationView.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 15/11/2022.
//

import SwiftUI

struct CreationView: View {
    
    private enum Constants {
        static let topOffset: CGFloat = 70.0
        static let spacing: CGFloat = 30.0
        
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
        enum TextField {
            static let height: CGFloat = 55.0
            static let color: Color = .white.opacity(0.08)
            static let cornerRadius: CGFloat = 20.0
            static let textInset: CGFloat = 10.0
            static let spacing: CGFloat = 15.0
        }
        enum Circle {
            static let opacity: CGFloat = 0.4
            static let blurRadius: CGFloat = 150.0
            static let offset: CGFloat = 100.0
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm: CreationViewModel
    
    @StateObject private var toastVM: ToastViewModel = ToastViewModel.shared
    @State private var originText: String = .empty
    @State private var presentNextStep: Bool = false
    @State private var isCreated: Bool = false
    
    var body: some View {
        ZStack {
            backgroundCircles
            
            VStack(spacing: Constants.spacing) {
                if vm.context == .alert {
                    currencyPicker
                }
                if vm.context == .asset {
                    originTextField
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
                
                Spacer()
                
                NavigationLink(destination: CreationValueView(vm: vm, isCreated: $isCreated), isActive: $vm.presentNextStep) {
                    RectangleButton(title: Localizable.nextButtonTitle.value, didButtonTapped: nextButtonTapped)
                }
            }
            .padding(.top, Constants.topOffset)
        }
        .toast(shouldShow: $toastVM.isShowing, type: toastVM.toast.type, message: toastVM.toast.message)
        .transition(.move(edge: .bottom))
        .onChange(of: isCreated) { newValue in
            presentationMode.wrappedValue.dismiss()
        }
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
    
    private var originTextField: some View {
        VStack(alignment: .leading, spacing: Constants.TextField.spacing) {
            if let vm = vm as? UserAssetCreationViewModel {
                Text("Asset origin: ")
                RoundedRectangle(cornerRadius: Constants.TextField.cornerRadius)
                    .fill(Constants.TextField.color)
                    .frame(height: Constants.TextField.height)
                    .overlay {
                        TextField("Enter origin...", text: $originText)
                            .padding(.leading, Constants.TextField.textInset)
                            .onChange(of: originText) { newValue in
                                vm.updateOrigin(newValue)
                            }
                    }
            }
        }
        .padding(.horizontal)
    }
    
    private var backgroundCircles: some View {
        ZStack {
            Circle()
                .fill(Color.lightBlue.opacity(Constants.Circle.opacity))
                .blur(radius: Constants.Circle.blurRadius)
                .offset(x: -Constants.Circle.offset, y: -Constants.Circle.offset)
            
            Circle()
                .fill(Color.lightGreen.opacity(Constants.Circle.opacity))
                .blur(radius: Constants.Circle.blurRadius)
                .offset(x: Constants.Circle.offset, y: Constants.Circle.offset)
        }
    }
    
    private func nextButtonTapped() {
        vm.navigateToNextStep {
            toastVM.show()
        }
    }

}

struct CreationView_Previews: PreviewProvider {
    static var previews: some View {
//        CreationView(vm: AlertCreationViewModel(service: AlertService()))
        CreationView(vm: UserAssetCreationViewModel(service: UserAssetService()))
    }
}
