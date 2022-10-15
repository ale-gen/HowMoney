//
//  Icons.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 14/10/2022.
//

import SwiftUI

protocol ImageTranslation {
    var value: Image { get }
}

extension ImageTranslation where Self: RawRepresentable, Self.RawValue == String {
    var value: Image {
        return Image(systemName: rawValue)
    }
}

enum Icons: String, ImageTranslation {
    
    case dollarSign = "dollarsign"
    case bell = "bell"
    case plus = "plus"
    case house = "house"
    case wallet = "dollarsign.circle"
    case transactions = "clock"
    case profile = "person"
    case selectedHouse = "house.fill"
    case selectedWallet = "dollarsign.circle.fill"
    case selectedTransactions = "clock.fill"
    case selectedProfile = "person.fill"
}