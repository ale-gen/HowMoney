//
//  Extension+String.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 14/10/2022.
//

import Foundation

extension String {
    
    static var empty: String {
        return ""
    }
    
    static var percentage: String {
        return "%"
    }
    
    static var plus: String {
        return "+"
    }
    
    static var minus: String {
        return "-"
    }
    
    static var zero: String {
        return "0.00"
    }
    
    static var dot: String {
        return "."
    }
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func date() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.date(from: self)
    }
    
    func preferenceCurrency() -> PreferenceCurrency {
        var preferenceCurrency: PreferenceCurrency
        switch self {
        case PreferenceCurrency.usd.name.lowercased():
            preferenceCurrency = .usd
        case PreferenceCurrency.eur.name.lowercased():
            preferenceCurrency = .eur
        case PreferenceCurrency.pln.name.lowercased():
            preferenceCurrency = .pln
        default:
            preferenceCurrency = .usd
        }
        return preferenceCurrency
    }
    
    func assetType() -> AssetType {
        var type: AssetType
        switch self {
        case "crypto":
            type = .cryptocurrency
        case "currency":
            type = .currency
        case "metal":
            type = .metal
        default:
            type = .currency
        }
        return type
    }
    
}
