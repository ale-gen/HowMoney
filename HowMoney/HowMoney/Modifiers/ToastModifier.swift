//
//  ToastModifier.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 17/11/2022.
//

import SwiftUI

struct ToastViewModifier: ViewModifier {
    
    private enum Constants {
        static let bottomOffset: CGFloat = -10.0
        static let animationDelay: CGFloat = 2.0
    }
    
    @Binding var shouldShow: Bool
    var type: ToastType
    var message: String
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if shouldShow {
                toast
                    .transition(.move(edge: .bottom))
                    .animation(.spring(), value: shouldShow)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.animationDelay) {
                            withAnimation(.spring()) {
                                shouldShow = false
                            }
                        }
                    }
            }
        }
    }
    
    private var toast: some View {
        VStack {
            Spacer()
            ToastView(shouldBeVisible: $shouldShow,
                      toastType: type,
                      subtitle: message)
                .padding(.horizontal)
                .padding(.bottom, Constants.bottomOffset)
        }
    }
    
}

extension View {
    
    func toast(shouldShow: Binding<Bool>, type: ToastType, message: String) -> some View {
        self.modifier(ToastViewModifier(shouldShow: shouldShow, type: type, message: message))
    }
    
}
