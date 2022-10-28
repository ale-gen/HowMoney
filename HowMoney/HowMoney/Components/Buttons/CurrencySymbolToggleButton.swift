//
//  CurrencySymbolToggleButton.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 29/10/2022.
//

import SwiftUI

struct CurrencySymbolToggleStyle: ToggleStyle {
    
    private enum Constants {
        static let width: CGFloat = 51.0
        static let height: CGFloat = 31.0
        static let cornerRadius: CGFloat = 30.0
        
        enum OnMode {
            static let foregroundColor: Color = .lightBlue
            static let offset: CGFloat = 11.0
        }
        enum OffMode {
            static let foregroundColor: Color = .gray
            static let offset: CGFloat = -11.0
        }
        enum Circle {
            static let padding: CGFloat = 3.0
        }
        enum Text {
            static let font: Font = .system(.caption)
        }
    }
    
    let isOnImage: String
    let isOffImage: String
    
    func makeBody(configuration: Configuration) -> some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .foregroundColor(configuration.isOn ? Constants.OnMode.foregroundColor : Constants.OffMode.foregroundColor)
            .frame(width: Constants.width, height: Constants.height)
            .overlay(
                Circle()
                    .foregroundColor(.white)
                    .padding(.all, Constants.Circle.padding)
                    .overlay(Text(configuration.isOn ? isOnImage : isOffImage)
                        .font(Constants.Text.font))
                    .offset(x: configuration.isOn ? Constants.OnMode.offset : Constants.OffMode.offset, y: .zero)
            )
            .onTapGesture {
                withAnimation(.spring()) {
                    configuration.isOn.toggle()
                }
            }
    }
}

struct CurrencySymbolToggleButton: View {
    
    @Binding var isOn: Bool
    let isOnImage: String
    let isOffImage: String
    
    var body: some View {
        Toggle(isOn: $isOn, label: { })
        .toggleStyle(CurrencySymbolToggleStyle(isOnImage: isOnImage, isOffImage: isOffImage))
    }
}

struct CurrencySymbolToggleButton_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySymbolToggleButton(isOn: .constant(true), isOnImage: "$", isOffImage: "zł")
    }
}
