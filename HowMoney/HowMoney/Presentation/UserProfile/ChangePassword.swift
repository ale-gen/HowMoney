//
//  ChangePassword.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 06/11/2022.
//

import SwiftUI

struct ChangePassword: View {
    
    private enum Constants {
        enum General {
            static let verticalInsets: CGFloat = 30.0
        }
        enum Circle {
            static let opacity: CGFloat = 0.4
            static let blurRadius: CGFloat = 150.0
            static let offset: CGFloat = 100.0
        }
        enum Image {
            static let maxHeight: CGFloat = 250.0
        }
        enum Toast {
            static let bottomOffset: CGFloat = -10.0
        }
        enum TextField {
            static let height: CGFloat = 55.0
            static let color: Color = .black.opacity(0.4)
            static let cornerRadius: CGFloat = 20.0
        }
    }
    
    @StateObject var vm: ChangePasswordViewModel = ChangePasswordViewModel()
    @State private var shouldShowToast: Bool = false
    
    var body: some View {
        ZStack {
            backgroundCircles
            
            VStack {
                Images.changePasswordIllustration.value
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: Constants.Image.maxHeight)
                Spacer()
                
                VStack {
                    textField(placeholder: Localizable.changePasswordCurrentPasswordPlaceholder.value, text: $vm.currentPasswordTextField)
                    textField(placeholder: Localizable.changePasswordNewPasswordPlaceholder.value, text: $vm.newPasswordTextField)
                    textField(placeholder: Localizable.changePasswordConfirmedNewPasswordPlaceholder.value, text: $vm.confirmedNewPasswordTextField)
                }
                .padding()
                
                Spacer()
                RectangleButton(title: Localizable.changePasswordSaveButtonTitle.value, didButtonTapped: sendForm)
            }
            
            if shouldShowToast {
                toast
            }
        }
        .padding(.vertical, Constants.General.verticalInsets)
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
    
    private var toast: some View {
        VStack {
            Spacer()
            ToastView(shouldBeVisible: $shouldShowToast,
                      toastType: .error,
                      subtitle: vm.errorMessage)
        }
        .padding(.horizontal)
        .padding(.bottom, Constants.Toast.bottomOffset)
        .transition(.move(edge: .bottom))
    }
    
    private func textField(placeholder: String, text: Binding<String>) -> some View {
        RoundedRectangle(cornerRadius: Constants.TextField.cornerRadius)
            .fill(Constants.TextField.color)
            .frame(height: Constants.TextField.height)
            .overlay {
                SecureField(placeholder, text: text)
                    .padding(.horizontal)
            }
    }
    
    private func sendForm() {
        vm.changePassword({
            print("Password is successfully changed!")
        }, {
            withAnimation(.spring()) {
                shouldShowToast = true
            }
        })
    }
}

struct ChangePassword_Previews: PreviewProvider {
    static var previews: some View {
        ChangePassword()
    }
}

struct ChangePassword_SmallerDevicePreviews: PreviewProvider {
    static var previews: some View {
        ChangePassword()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
    }
}
