//
//  CreationValueView.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 26/11/2022.
//

import SwiftUI

struct CreationValueView: View {
    private enum Constants {
        static let spacing: CGFloat = 20.0
        
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
    @EnvironmentObject var userStateVM: UserStateViewModel
    @StateObject var vm: CreationViewModel
    @Binding var isCreated: Bool
    
    @State private var textValue: String = Constants.ValueLabel.defaultValue
    @StateObject private var toastVM: ToastViewModel = ToastViewModel.shared
    
    var body: some View {
        VStack {
            Spacer()
            valueLabel
                .padding(.bottom, Constants.spacing)
            Spacer()
            RectangleButton(title: vm.context?.buttonTitle ?? .empty, didButtonTapped: sendForm)
                .padding(.bottom, Constants.spacing)
            
            KeyboardView(vm: vm.prepareKeyboardViewModel(),
                         textValue: $textValue)
                .frame(maxHeight: Constants.Keyboard.maxHeight)
        }
        .navigationTitle(vm.selectedAsset?.friendlyName.uppercased() ?? .empty)
        .navigationBarHidden(false)
        .navigationBarTitleDisplayMode(.inline)
        .toast(shouldShow: $toastVM.isShowing, type: toastVM.toast.type, message: toastVM.toast.message)
    }
    
    private var valueLabel: some View {
        ZStack {
            HStack {
                Spacer()
                Text(textValue)
                Text(vm.currencySymbol)
                Spacer()
            }
            .foregroundColor(Constants.ValueLabel.color)
            .font(Constants.ValueLabel.font)
        }
    }
    
    private func sendForm() {
        vm.create(successCompletion: {
            print("Success 🥳")
            toastVM.show()
            DispatchQueue.main.sync {
                presentationMode.wrappedValue.dismiss()
                isCreated = true
            }
        }, failureCompletion: {
            print("Failure 🫠")
            toastVM.show()
        })
    }
}

struct CreationValueView_Previews: PreviewProvider {
    static var previews: some View {
        CreationValueView(vm: UserAssetCreationViewModel(service: UserAssetService()), isCreated: .constant(false))
    }
}
