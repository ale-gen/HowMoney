//
//  Localizable.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 14/10/2022.
//

import Foundation

protocol Translation {
    var value: String { get }
}

extension Translation where Self: RawRepresentable, Self.RawValue == String {
    
    var value: String {
        return rawValue.localized()
    }
}

enum Localizable: String, Translation {
    
    // MARK: Welcome screen
    case welcomeSwipeToGetStarted = "welcome.swipe.to.get.started.title"
    case welcomeCompanySloganText = "welcome.company.slogan.text"
    
    // MARK: Preference currency
    case namePolishZlotyCurrency = "name.polish.zloty.currency"
    case nameDollarCurrency = "name.dollar.currency"
    case nameEuroCurrency = "name.euro.currency"
    case friendlyNamePolishZlotyCurrency = "friendly.name.polish.zloty.currency"
    case friendlyNameDollarCurrency = "friendly.name.dollar.currency"
    case friendlyNameEuroCurrency = "friendly.name.euro.currency"
    
    // MARK: Authorization
    case authorizationSignOutButtonTitle = "authorization.sign.out.button.title"
    
    
}
