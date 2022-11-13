//
//  UserAssetEditingView.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 12/11/2022.
//

import SwiftUI

struct UserAssetEditingView: View {
    
    private enum Constants {
        static let spacing: CGFloat = 20.0
        
        enum ValueLabel {
            static let maxHeight: CGFloat = 150.0
            static let font: Font = .system(size: 40.0)
            static let color: Color = .white
            static let defaultValue: String = "0.00"
        }
        enum TipLabel {
            static let textColor: Color = .white.opacity(0.7)
            static let horizontalInsets: CGFloat = 20.0
            static let spacing: CGFloat = 5.0
            static let finalValueFont: Font = .headline.weight(.semibold)
            static let finalValueColor: Color = .white.opacity(0.9)
        }
        enum Keyboard {
            static let maxHeight: CGFloat = 300.0
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm: UserAssetEditingViewModel
    @State private var textValue: String = Constants.ValueLabel.defaultValue
    
    var body: some View {
        VStack {
            Spacer()
            valueLabel
                .padding(.bottom, Constants.spacing)
            tipLabel
            Spacer()
            RectangleButton(title: vm.operation.title, didButtonTapped: sendForm)
                .padding(.bottom, Constants.spacing)
            
            KeyboardView(vm: vm.prepareKeyboardViewModel(),
                         textValue: $textValue)
                .frame(maxHeight: Constants.Keyboard.maxHeight)
        }
        .navigationTitle(vm.userAsset.asset.friendlyName)
        .navigationBarHidden(false)
    }
    
    private var valueLabel: some View {
        ZStack {
            HStack {
                Spacer()
                Text(vm.operation == .substract ? BalanceChar.negative.text : BalanceChar.positive.text)
                Text(textValue)
                Text(vm.userAsset.asset.symbol ?? .empty)
                Spacer()
            }
            .foregroundColor(Constants.ValueLabel.color)
            .font(Constants.ValueLabel.font)
        }
    }
    
    private var tipLabel: some View {
        VStack(spacing: Constants.TipLabel.spacing) {
            Text(vm.operation == .update ? Localizable.userAssetsEditingNewValueLabel.value : Localizable.userAssetsEditingFinalValueLabel.value)
                .foregroundColor(Constants.TipLabel.textColor)
            AssetValueLabel(value: vm.finalValue,
                            symbol: vm.userAsset.asset.symbol,
                            type: vm.userAsset.asset.type)
                .font(Constants.TipLabel.finalValueFont)
                .foregroundColor(Constants.TipLabel.finalValueColor)
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal, Constants.TipLabel.horizontalInsets)
    }
    
    private func sendForm() {
        vm.updateUserAsset(successCompletion: {
            print("Success 🥳")
            DispatchQueue.main.async {
                presentationMode.wrappedValue.dismiss()
            }
        }, failureCompletion: {
            print("Failure 🫠")
        })
    }
}

struct UserAssetEditingView_Previews: PreviewProvider {
    static var previews: some View {
        UserAssetEditingView(vm: UserAssetEditingViewModel(service: UserAssetService(),
                                                           userAsset: UserAsset.UserAssetsMock.first!,
                                                           operation: .add))
    }
}
