//
//  PreferenceCurrency.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 12/10/2022.
//

import Foundation

enum PreferenceCurrency: String {
    case pln
    case usd
    case eur
    
    var symbol: String {
        switch self {
        case .pln:
            return Localizable.namePolishZlotyCurrency.value
        case .usd:
            return "$"
        case .eur:
            return "€"
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
