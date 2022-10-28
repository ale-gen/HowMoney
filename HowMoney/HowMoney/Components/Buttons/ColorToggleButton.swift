//
//  ToggleButton.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 23/10/2022.
//

import SwiftUI

struct ColorToggleButton: View {
    
    private enum Constants {
        static let height: CGFloat = 40.0
        static let horizontalInsets: CGFloat = 20.0
        static let tintColor: Color = .lightBlue
        static let labelColor: Color = .white
    }
    
    @Binding var isOn: Bool
    var textLabel: String
    
    var body: some View {
        HStack {
            Toggle(isOn: $isOn) {
                Text(textLabel)
                    .foregroundColor(Constants.labelColor)
            }
            .toggleStyle(SwitchToggleStyle(tint: Constants.tintColor))
        }
        .frame(height: Constants.height)
        .padding(.horizontal, Constants.horizontalInsets)
    }
}

struct ColorToggleButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ColorToggleButton(isOn: .constant(true), textLabel: "Toggle label")
        }
    }
}
