//
//  Alert.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 15/10/2022.
//

import Foundation

struct Alert {
    let targetValue: Float
    let originAssetName: String
    let originAssetType: AssetType
    let targetCurrency: PreferenceCurrency
    
    static let AlertsMock: [Alert] = [
        .init(targetValue: 4.6, originAssetName: "EUR", originAssetType: .currency, targetCurrency: .pln),
        .init(targetValue: 4.5, originAssetName: "EUR", originAssetType: .currency, targetCurrency: .pln),
        .init(targetValue: 4.9, originAssetName: "USD", originAssetType: .currency, targetCurrency: .pln),
        .init(targetValue: 30.0, originAssetName: "SOL", originAssetType: .cryptocurrency, targetCurrency: .usd),
        .init(targetValue: 298.0, originAssetName: "ZL750", originAssetType: .metal, targetCurrency: .pln)
    ]
}
