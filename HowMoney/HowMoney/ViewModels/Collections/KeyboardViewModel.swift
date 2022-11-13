//
//  KeyboardViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 13/11/2022.
//

import SwiftUI

class KeyboardViewModel: ObservableObject {
    
    private enum Constants {
        static let defaultTextValue: String = .zero
    }
    
    private(set) var textValue: String = Constants.defaultTextValue
    private var assetType: AssetType
    
    init(assetType: AssetType) {
        self.assetType = assetType
    }
    
    func didTapButton(_ button: KeyboardButtonType) {
        switch button {
        case let .number(stringNumber):
            if textValue == Constants.defaultTextValue {
                textValue = stringNumber
                return
            } else if !textValue.contains(.dot) || textValue.last == .dot {
                textValue += stringNumber
                return
            }
            
            guard let currentDecimalPlaces = textValue.split(separator: .dot).last?.count,
                    currentDecimalPlaces < assetType.decimalPlaces
            else { return }
            
            textValue += stringNumber
        case .clear:
            if textValue != Constants.defaultTextValue {
                if textValue.count > .one {
                    textValue.removeLast()
                } else {
                    textValue = Constants.defaultTextValue
                }
            }
        case let .decimalComma(char):
            guard !textValue.contains(char) && (textValue.count > .zero) else { return }
            textValue.append(char)
        }
    }
    
}
