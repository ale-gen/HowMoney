//
//  UserPreferencesDTO.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 14/11/2022.
//

import Foundation

struct UserPreferencesDTO: Decodable {
    let preferenceCurrency: String
    let weeklyReports: Bool
    let alertsOnEmail: Bool
}
