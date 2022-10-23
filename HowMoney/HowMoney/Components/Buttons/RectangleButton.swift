//
//  RectangleButton.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 21/10/2022.
//

import SwiftUI

struct RectangleButton: View {
    
    private enum Constants {
        static let fontColor: Color = .white
        static let height: CGFloat = 50.0
        static let backgroundColor: Color = .lightBlue
        static let cornerRadius: CGFloat = 10.0
        static let padding: CGFloat = 20.0
        static let shadowColor: Color = .gray.opacity(0.6)
        static let shadowRadius: CGFloat = 5.0
    }
    
    var title: String
    var didButtonTapped: (() -> Void)?
    
    var body: some View {
        Button(title) {
            didButtonTapped?()
        }
        .frame(maxWidth: .infinity)
        .frame(height: Constants.height)
        .foregroundColor(Constants.fontColor)
        .background(Constants.backgroundColor)
        .cornerRadius(Constants.cornerRadius)
        .padding(Constants.padding)
        .shadow(color: Constants.shadowColor, radius: Constants.shadowRadius)
    }
}

struct RectangleButton_Previews: PreviewProvider {
    static var previews: some View {
        RectangleButton(title: Localizable.authorizationSignOutButtonTitle.value)
    }
}
