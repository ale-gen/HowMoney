//
//  ConditionalModifier.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 05/11/2022.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func conditionalModifier<Transformed : View>(_ condition: Bool, _ transform: (Self) -> Transformed) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
