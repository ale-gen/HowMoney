//
//  KeyboardViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 13/11/2022.
//

import SwiftUI

class KeyboardViewModel: ObservableObject {
    
    private enum Constants {
        static let defaultTextValue: String = "0.00"
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
            } else if !textValue.contains(".") || textValue.last == "." {
                textValue += stringNumber
                return
            }
            
            guard let currentDecimalPlaces = textValue.split(separator: ".").last?.count,
                    currentDecimalPlaces < assetType.decimalPlaces
            else { return }
            
            textValue += stringNumber
        case .clear:
            if textValue != Constants.defaultTextValue {
                if textValue.count > 1 {
                    textValue.removeLast()
                } else {
                    textValue = Constants.defaultTextValue
                }
            }
        case let .decimalComma(char):
            guard !textValue.contains(char) && (textValue.count > 0) else { return }
            textValue.append(char)
        }
    }
    
}
