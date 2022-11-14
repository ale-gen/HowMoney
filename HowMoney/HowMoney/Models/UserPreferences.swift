//
//  UserPreferences.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 14/11/2022.
//

import Foundation

struct UserPreferences {
    let preferenceCurrency: PreferenceCurrency
    let weeklyReports: Bool
    let alertsOnEmail: Bool
    
    static func parse(from model: UserPreferencesDTO) -> UserPreferences {
        var preferenceCurrency: PreferenceCurrency
        switch model.preferenceCurrency.lowercased() {
        case PreferenceCurrency.usd.name.lowercased():
            preferenceCurrency = .usd
        case PreferenceCurrency.eur.name.lowercased():
            preferenceCurrency = .eur
        case PreferenceCurrency.pln.name.lowercased():
            preferenceCurrency = .pln
        default:
            preferenceCurrency = .usd
        }
        return UserPreferences(preferenceCurrency: preferenceCurrency, weeklyReports: model.weeklyReports, alertsOnEmail: model.alertsOnEmail)
    }
}
