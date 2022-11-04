//
//  NavigateModifier.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 03/11/2022.
//

import SwiftUI

extension View {
    
    func navigate<Destination: View>(destination: Destination, when: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationTitle(String.empty)
                    .navigationBarHidden(true)
                
                NavigationLink(destination: destination.navigationBarHidden(true),
                               isActive: when) {
                    EmptyView()
                }
            }
        }
    }
}
