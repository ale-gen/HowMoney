//
//  Balance.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 12/10/2022.
//

import SwiftUI

struct Balance {
    let value: Float
    let currency: PreferenceCurrency
}

struct MonthlyProfit {
    let value: Float
    let currency: PreferenceCurrency
    let isIncreased: Bool
}

enum BalanceChar {
    case positive
    case negative
    
    var text: String {
        switch self {
        case .positive:
            return "+"
        case .negative:
            return "-"
        }
    }
    
    var arrowImage: Image {
        switch self {
        case .positive:
            return Image(systemName: "arrowtriangle.up.fill")
        case .negative:
            return Image(systemName: "arrowtriangle.down.fill")
        }
    }
}
