//
//  Images.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 22/10/2022.
//

import SwiftUI

protocol ImageTranslation {
    var value: Image { get }
}

extension ImageTranslation where Self: RawRepresentable, Self.RawValue == String {
    var value: Image {
        return Image(rawValue)
    }
}

enum Images: String, ImageTranslation {
    
    case assetsBubbles = "assetsBubbles"
    case fullLogo = "fullLogo"
    case appLogo = "logo"
    case plnSymbol = "pln"
    case eurSymbol = "eur"
    case usdSymbol = "usd"
    case noAssets = "noAssets"
    case noAlerts = "noAlerts"
    case cashIn = "cashIn"
    case cashOut = "cashOut"
    case cashEdit = "cashEdit"
    case preferenceCurrencyIllustration = "preferenceCurrencyIllustration"
    case alertsIllustration = "alertsIllustration"
    case weeklyReportsIllustration = "weeklyReportsIllustration"
    case changePasswordIllustration = "changePasswordIllustration"
}
