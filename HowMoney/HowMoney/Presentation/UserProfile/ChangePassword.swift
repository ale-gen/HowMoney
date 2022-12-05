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
            static let spacing: CGFloat = 40.0
        }
        enum Circle {
            static let opacity: CGFloat = 0.4
            static let blurRadius: CGFloat = 150.0
            static let offset: CGFloat = 100.0
        }
        enum Image {
            static let maxHeight: CGFloat = 250.0
        }
        enum Description {
            static let cornerRadius: CGFloat = 20.0
            static let height: CGFloat = 120.0
            static let color: Color = .black.opacity(0.4)
            static let horizontalInsets: CGFloat = 20.0
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm: ChangePasswordViewModel = ChangePasswordViewModel(service: Services.authService)
    @State private var shouldShowToast: Bool = false
    @State private var toastVM: ToastViewModel = ToastViewModel.shared
    
    var body: some View {
        ZStack {
            backgroundCircles
            
            VStack(spacing: Constants.General.spacing) {
                Images.changePasswordIllustration.value
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: Constants.Image.maxHeight)
                
                description
                Spacer()
                RectangleButton(title: Localizable.changePasswordSendRequestButtonTitle.value, didButtonTapped: sendForm)
            }
        }
        .toast(shouldShow: $shouldShowToast, type: vm.toastType, message: vm.toastMessage)
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
    
    private var description: some View {
        RoundedRectangle(cornerRadius: Constants.Description.cornerRadius)
            .fill(Constants.Description.color)
            .frame(height: Constants.Description.height)
            .overlay {
                Text(Localizable.changePasswordDescriptionText.value)
                    .padding(.horizontal, Constants.Description.horizontalInsets)
            }
            .padding(.horizontal)
    }
    
    private func sendForm() {
        vm.changePassword(successCompletion: {
            print("Success 🥳")
            toastVM.show()
            DispatchQueue.main.async {
                presentationMode.wrappedValue.dismiss()
            }
        }, failureCompletion: {
            withAnimation(.spring()) {
                shouldShowToast = true
            }
            print("Failure 🫠")
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
