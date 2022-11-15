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
        return UserPreferences(preferenceCurrency: model.preferenceCurrency.lowercased().preferenceCurrency(), weeklyReports: model.weeklyReports, alertsOnEmail: model.alertsOnEmail)
    }
}
