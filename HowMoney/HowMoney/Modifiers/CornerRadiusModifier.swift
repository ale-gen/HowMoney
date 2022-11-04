//
//  CornerRadiusModifier.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 04/11/2022.
//

import SwiftUI

extension View {
    
    func cornerRadius(_ radius: CGFloat, _ corners: [UIRectCorner]) -> some View {
        ZStack {
            switch corners {
            case [.topLeft, .topRight]:
                self
                    .padding(.bottom, radius)
                    .cornerRadius(radius)
                    .padding(.bottom, -radius)
            case [.bottomLeft, .bottomRight]:
                self
                    .padding(.top, radius)
                    .cornerRadius(radius)
                    .padding(.top, -radius)
            default:
                self.cornerRadius(radius)
            }
        }
        
    }
    
}
