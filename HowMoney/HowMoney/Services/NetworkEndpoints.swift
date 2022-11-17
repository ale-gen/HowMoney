//
//  NetworkEndpoints.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 09/11/2022.
//

import Foundation

enum NetworkEndpoints: String {
    
    case alerts =  "/api/alerts"
    case assets = "/api/assets"
    case assetHistory = "/api/asset-values"
    case userAssets = "/api/users/me/assets"
    case userPreferences = "/api/users/me/preferences"
    case transactions = "/api/transactions"
}
