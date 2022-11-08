//
//  LoaderModifiers.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 08/11/2022.
//

import SwiftUI

struct LoaderViewModifier: ViewModifier {
    
    @Binding var loader: LoaderView?
    @Binding var didActionFinished: Bool
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(loader)
            .onChange(of: didActionFinished) { _ in
                loader = nil
            }
    }
    
}

extension View {
    
    func loader(loader: Binding<LoaderView?>, shouldHideLoader: Binding<Bool>) -> some View {
        self.modifier(LoaderViewModifier(loader: loader, didActionFinished: shouldHideLoader))
    }
    
}
