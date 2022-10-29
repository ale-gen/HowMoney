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
    
    // MARK: User profile
    case userProfileWeeklyReportsLabelText = "user.profile.weekly.reports.label.text"
    case userProfileEmailAlertsLabelText = "user.profile.email.alerts.label.text"
    case userProfilePreferenceCurrencyLabelText = "user.profile.preference.currency.label.text"
    case userProfileBiometricsLabelText = "user.profile.preference.biometrics.label.text"
    
    // MARK: Assets types
    case assetsAllTypesText = "assets.all.types.text"
    case assetsCurrencyTypeName = "assets.currency.type.name"
    case assetsCryptocurrencyTypeName = "assets.cryptocurrency.type.name"
    case assetsMetalTypeName = "assets.metal.type.name"
    
    // MARK: User assets collection
    case userAssetsEmptyStateTitle = "user.assets.empty.state.title"
    case userAssetsCreateNewButtonTitle =  "user.assets.create.new.button.title"
    
    // MARK: User asset details
    case userAssetDetailsPriceUpdateTime = "user.asset.details.price.update.time"
    case userAssetDetailsAddOperationTitle = "user.asset.details.add.operation.title"
    case userAssetDetailsSubstractOperationTitle = "user.asset.details.substract.operation.title"
    case userAssetDetailsEditOperationTitle = "user.asset.details.edit.operation.title"
    
    // MARK: Alerts
    case alertsEmptyStateTitle = "alerts.empty.state.title"
    case alertsCreateNewButtonTitle = "alerts.create.new.button.title"
}
