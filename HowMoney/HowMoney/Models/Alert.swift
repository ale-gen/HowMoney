//
//  Alert.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 15/10/2022.
//

import Foundation

struct Alert: Hashable {
    let id: Int
    let targetValue: Float
    let originAssetName: String
    let originAssetType: AssetType
    let targetCurrency: PreferenceCurrency
    
    static func parse(from alert: AlertDTO) -> Alert {
        return Alert(id: alert.alertId, targetValue: alert.value, originAssetName: alert.originAssetName, originAssetType: alert.originAssetType.lowercased().assetType(), targetCurrency: alert.currency.lowercased().preferenceCurrency())
    }
    
    static let AlertsMock: [Alert] = [
        .init(id: 1, targetValue: 4.6, originAssetName: "EUR", originAssetType: .currency, targetCurrency: .pln),
        .init(id: 2, targetValue: 4.5, originAssetName: "EUR", originAssetType: .currency, targetCurrency: .pln),
        .init(id: 3, targetValue: 4.9, originAssetName: "USD", originAssetType: .currency, targetCurrency: .pln),
        .init(id: 4, targetValue: 30.0, originAssetName: "SOL", originAssetType: .cryptocurrency, targetCurrency: .usd),
        .init(id: 5, targetValue: 298.0, originAssetName: "ZL750", originAssetType: .metal, targetCurrency: .pln)
    ]
}
