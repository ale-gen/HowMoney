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
    
    func value(_ value: String) -> String {
        return rawValue.localizedWithFormat(value)
    }
    
}

enum Localizable: String, Translation {
    
    // MARK: Welcome screen
    case welcomeSwipeToGetStarted = "welcome.swipe.to.get.started.title"
    case welcomeCompanySloganText = "welcome.company.slogan.text"
    
    // MARK: Onboarding user customization
    case onboardingUserCustomizationPreferenceCurrencyDescription = "onboarding.user.customization.preference.currency.description"
    case onboardingUserCustomizationEmailAlertsDescription = "onboarding.user.customization.email.alerts.description"
    case onboardingUserCustomizationWeeklyReportsDescription = "onboarding.user.customization.weekly.reports.description"
    
    // MARK: Preference currency
    case namePolishZlotyCurrency = "name.polish.zloty.currency"
    case nameDollarCurrency = "name.dollar.currency"
    case nameEuroCurrency = "name.euro.currency"
    case friendlyNamePolishZlotyCurrency = "friendly.name.polish.zloty.currency"
    case friendlyNameDollarCurrency = "friendly.name.dollar.currency"
    case friendlyNameEuroCurrency = "friendly.name.euro.currency"
    
    // MARK: Authorization
    case authorizationSignOutButtonTitle = "authorization.sign.out.button.title"
    
    // MARK: Home
    case walletTotalBalanceTitle = "wallet.total.balance.title"
    case walletCurrencyBalanceTitle = "wallet.currency.balance.title"
    case walletCryptocurrencyBalanceTitle = "wallet.cryptocurrency.balance.title"
    case walletMetalBalanceTitle = "wallet.metal.balance.title"
    case walletTotalBalanceSubtitle = "wallet.total.balance.subtitle"
    
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
    case alertsNotifyWhenText = "alerts.notify.when.text"
    case alertsAssetTypeText = "alerts.asset.type.text"
    case alertsCollectionTitle = "alerts.collection.title"
    case alertsCollectionSeeAllButtonTitle = "alerts.collection.see.all.button.title"
    
    // MARK: Transactions
    case transactionsEmptyStateTitle = "transactions.empty.state.title"
    
    // MARK: User assets creation
    case userAssetsCreationSelectionPromptText = "user.assets.creation.selection.prompt.text"
    case userAssetsCreationNavBarTitle = "user.assets.creation.nav.bar.title"
    case userAssetsCreationAddToMyWalletButtonTitle = "user.assets.creation.add.to.my.wallet.button.title"
    case userAssetsCreationDecimalPlacesValidation = "user.assets.creation.decimal.places.validation"
    case userAssetsCreationPositiveNumberValidation = "user.assets.creation.positive.number.validation"
    case userAssetsCreationAssetSelectionValidation = "user.assets.creation.asset.selection.validation"
    case userAssetsCreationValueValidationToastMessageText = "user.assets.creation.value.validation.toast.message.text"
    case userAssetsCreationSuccessToastMessageText = "user.assets.creation.success.toast.message.text"
    
    // MARK: User assets deletion
    case userAssetsDeletionAlertMessageTitle = "user.assets.deletion.alert.message"
    
    // MARK: Alerts creation
    case alertsCreationNavBarTitle = "alerts.creation.nav.bar.title"
    case alertsCreationNotifyMeButtonTitle = "alerts.creation.notify.me.button.title"
    case alertsCreationSelectionPromptText = "alerts.creation.selection.prompt.text"
    case alertsCreationTargetCurrencyText = "alerts.creation.target.currency.text"
    case alertsCreationTargetValueValidation = "alerts.creation.target.value.validation"
    case alertsCreationPositiveNumberValidation = "alerts.creation.positive.number.validation"
    case alertsCreationAssetSelectionValidation = "alerts.creation.asset.selection.validation"
    case alertsCreationSuccessToastMessageText = "alerts.creation.success.toast.message.text"
    
    // MARK: User assets editing
    case userAssetsEditingFinalValueLabel = "user.assets.editing.final.value.label"
    case userAssetsEditingNewValueLabel = "user.assets.editing.new.value.label"
    case userAssetsEditingValueValidationToastMessageText = "user.assets.editing.value.validation.toast.message.text"
    case userAssetsEditingAssetUpdatedToastMessageText = "user.assets.editing.asset.updated.toast.message.text"
    
    // MARK: Toast view
    case toastViewErrorTitle = "toast.view.error.title"
    case toastViewSuccessTitle = "toast.view.success.title"
    case toastViewFailedOperationMessageText = "toast.view.failed.operation.message.text"
    
    // MARK: Change password
    case changePasswordLabel = "change.password.label"
    case changePasswordSaveButtonTitle = "change.password.save.button.title"
    case changePasswordCurrentPasswordPlaceholder = "change.password.current.password.placeholder"
    case changePasswordNewPasswordPlaceholder = "change.password.new.password.placeholder"
    case changePasswordConfirmedNewPasswordPlaceholder = "change.password.confirmed.new.password.placeholder"
    case changePasswordCompatibilityValidationText = "change.password.compatibility.validation.text"
    case changePasswordEmptyFieldValidationText = "change.password.empty.field.validation.text"
    case changePasswordCurrentPasswordValidationText = "change.password.current.password.validation.text"
    case changePasswordSuccesText = "change.password.success.text"
    
    // MARK: Button titles
    case deleteButtonTitle = "delete.button.title"
    
}
