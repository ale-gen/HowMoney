//
//  PreferenceCurrency.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 12/10/2022.
//

import SwiftUI

enum PreferenceCurrency: String, CaseIterable {
    case pln
    case usd
    case eur
    
    var symbol: String {
        switch self {
        case .pln:
            return "zł"
        case .usd:
            return "$"
        case .eur:
            return "€"
        }
    }
    
    var image: Image {
        switch self {
        case .pln:
            return Images.plnSymbol.value
        case .usd:
            return Images.usdSymbol.value
        case .eur:
            return Images.eurSymbol.value
        }
    }
    
    var name: String {
        switch self {
        case .pln:
            return Localizable.namePolishZlotyCurrency.value
        case .usd:
            return Localizable.nameDollarCurrency.value
        case .eur:
            return Localizable.nameEuroCurrency.value
        }
    }
    
    var friendlyName: String {
        switch self {
        case .pln:
            return Localizable.friendlyNamePolishZlotyCurrency.value
        case .usd:
            return Localizable.friendlyNameDollarCurrency.value
        case .eur:
            return Localizable.friendlyNameEuroCurrency.value
        }
    }
}
