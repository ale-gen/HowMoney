//
//  GradientCell.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 05/11/2022.
//

import SwiftUI

struct GradientCell: View {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 20.0
        
        enum Gradient {
            static let firstStopLocation: CGFloat = -0.4
            static let firstStopColor: Color = .black
            static let secondStopLocation: CGFloat = 1.0
            static let secondStopOpacity: CGFloat = 0.4
        }
        enum Rectangle {
            static let color: Color = .black.opacity(0.25)
        }
    }
    
    var gradientColor: Color
    
    var body: some View {
        ZStack {
            LinearGradient(stops: [
                .init(color: Constants.Gradient.firstStopColor, location: Constants.Gradient.firstStopLocation),
                .init(color: gradientColor.opacity(Constants.Gradient.secondStopOpacity), location: Constants.Gradient.secondStopLocation)],
                           startPoint: .leading, endPoint: .trailing)
            
            Rectangle()
                .fill(Constants.Rectangle.color)
                .background(.ultraThinMaterial)
        }
        .cornerRadius(Constants.cornerRadius, [.allCorners])
    }
}

struct GradientCell_Previews: PreviewProvider {
    static var previews: some View {
        GradientCell(gradientColor: .lightGreen)
    }
}
