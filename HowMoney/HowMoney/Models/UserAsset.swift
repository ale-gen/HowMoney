//
//  UserAsset.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 15/10/2022.
//

import SwiftUI

enum UserAssetOperation {
    case add
    case substract
    case update
    
    var title: String {
        switch self {
        case .add:
            return Localizable.userAssetDetailsAddOperationTitle.value
        case .substract:
            return Localizable.userAssetDetailsSubstractOperationTitle.value
        case .update:
            return Localizable.userAssetDetailsEditOperationTitle.value
        }
    }
    
    var icon: Image {
        switch self {
        case .add:
            return Images.cashIn.value
        case .substract:
            return Images.cashOut.value
        case .update:
            return Images.cashEdit.value
        }
    }
    
    var multiplier: Float {
        switch self {
        case .add, .update:
            return 1.0
        case .substract:
            return -1.0
        }
    }
    
    var requestValueType: String {
        switch self {
        case .add, .substract:
            return "Update"
        case .update:
            return "Set"
        }
    }
}

struct UserAsset: Identifiable, Hashable {
    
    var id: UUID = UUID()
    let asset: Asset
    let originValue: Float
    let preferenceCurrencyValue: Float
    let origin: String
    
    static func parse(from userAsset: UserAssetDTO) -> UserAsset {
        UserAsset(asset: Asset.parse(from: userAsset.asset), originValue: userAsset.originValue, preferenceCurrencyValue: userAsset.userCurrencyValue, origin: userAsset.description)
    }
    
    static func ==(lhs: UserAsset, rhs: UserAsset) -> Bool {
        return lhs.id == rhs.id
    }
    
    static let polishZloty = Asset(name: "PLN", friendlyName: "Polish Zloty", symbol: "zł", type: .currency)
    static let americanDollar = Asset(name: "USD", friendlyName: "US Dollar", symbol: "$", type: .currency)
    static let euro = Asset(name: "EUR", friendlyName: "Euro", symbol: "€", type: .currency)
    static let swissFranc = Asset(name: "CHF", friendlyName: "Swiss Franc", symbol: "₣", type: .currency)
    
    static let pancakeSwap = Asset(name: "CAKE", friendlyName: "PancakeSWAP", symbol: nil, type: .cryptocurrency)
    static let polygon = Asset(name: "MATIC", friendlyName: "Polygon", symbol: nil, type: .cryptocurrency)
    
    static let UserAssetsMock: [UserAsset] = [
        .init(asset: polishZloty, originValue: 2600.9, preferenceCurrencyValue: 1600.9, origin: "Cash"),
        .init(asset: americanDollar, originValue: 126.78, preferenceCurrencyValue: 609.90, origin: "Cash"),
        .init(asset: euro, originValue: 2300.0, preferenceCurrencyValue: 8900.89, origin: "Cash"),
        .init(asset: swissFranc, originValue: 0.0, preferenceCurrencyValue: 0.0, origin: "PKO"),
        .init(asset: pancakeSwap, originValue: 10.34, preferenceCurrencyValue: 390.21, origin: "Revolut"),
        .init(asset: polygon, originValue: 12.0, preferenceCurrencyValue: 65.7, origin: "Revolut")
    ]
}

struct UserAssetsHistoryRecord {
    let value: Float
    let date: Date
    
    private static let DatesMock: [Date] = [
        "26/09/2022", "27/09/2022", "28/09/2022", "29/09/2022", "30/09/2022", "01/10/2022", "02/10/2022", "03/10/2022", "04/10/2022", "05/10/2022", "06/10/2022", "07/10/2022", "08/10/2022", "09/10/2022", "10/10/2022", "11/10/2022", "12/10/2022", "13/10/2022", "14/10/2022", "15/10/2022"
    ].compactMap { $0.date() }
    
    private static let ValuesMock: [Float] = [
        3000.0, 3020.45, 3030.56, 2600.0, 2650.0, 2645.0, 2635.45, 2635.90, 2636.10, 2590.50, 2595.0, 2599.45, 2599.67, 3200.90, 3201.1, 3202.4, 3205.64, 3204.80, 3199.99, 3200.01
    ]
    
    static let UserAssetsHistoryRecordsMock: [UserAssetsHistoryRecord] = zip(ValuesMock, DatesMock).map { .init(value: $0, date: $1) }
}
