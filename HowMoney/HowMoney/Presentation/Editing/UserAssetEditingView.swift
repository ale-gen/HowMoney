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
        }
        enum TipLabel {
            static let textColor: Color = .white.opacity(0.7)
            static let horizontalInsets: CGFloat = 20.0
        }
        enum Keyboard {
            static let maxHeight: CGFloat = 300.0
        }
    }
    
    @StateObject var vm: UserAssetEditingViewModel
    
    var body: some View {
        VStack {
            Spacer()
            valueLabel
                .padding(.bottom, Constants.spacing)
            tipLabel
            Spacer()
            RectangleButton(title: vm.operation.title, didButtonTapped: sendForm)
                .padding(.bottom, Constants.spacing)
            
            KeyboardView()
                .frame(maxHeight: Constants.Keyboard.maxHeight)
        }
        .navigationTitle(vm.userAsset.asset.friendlyName)
        .navigationBarHidden(false)
    }
    
    private var valueLabel: some View {
        ZStack {
            // TODO: Ensure typing correct number of decimal places depends on chosen asset type
            HStack {
                Spacer()
                Text("0.00")
                Text(vm.userAsset.asset.symbol ?? .empty)
                Spacer()
            }
            .foregroundColor(Constants.ValueLabel.color)
            .font(Constants.ValueLabel.font)
        }
    }
    
    private var tipLabel: some View {
        Text("After operation asset balance will be equal \(vm.finalValue)")
            .multilineTextAlignment(.center)
            .foregroundColor(Constants.TipLabel.textColor)
            .padding(.horizontal, Constants.TipLabel.horizontalInsets)
    }
    
    private func sendForm() {
        vm.updateUserAsset(successCompletion: {
            print("Success 🥳")
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
