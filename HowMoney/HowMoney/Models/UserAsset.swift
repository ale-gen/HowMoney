//
//  UserAsset.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 15/10/2022.
//

import Foundation

enum UserAssetOperation {
    case add
    case substract
    case update
}

struct UserAsset {
    let asset: Asset
    let value: Float
    
    static let polishZloty = Asset(assetId: "1", assetName: "PLN", assetFriendlyName: "Polish Zloty", assetType: .currency)
    static let americanDollar = Asset(assetId: "2", assetName: "USD", assetFriendlyName: "US Dollar", assetType: .currency)
    static let euro = Asset(assetId: "3", assetName: "EUR", assetFriendlyName: "Euro", assetType: .currency)
    static let switzerlandFranc = Asset(assetId: "4", assetName: "CHF", assetFriendlyName: "Swiss Franc", assetType: .currency)
    
    static let pancakeSwap = Asset(assetId: "2", assetName: "CAKE", assetFriendlyName: "PancakeSWAP", assetType: .cryptocurrency)
    static let polygon = Asset(assetId: "3", assetName: "MATIC", assetFriendlyName: "Polygon", assetType: .cryptocurrency)
    
    static let UserAssetsMock: [UserAsset] = [
        .init(asset: polishZloty, value: 2600.9),
        .init(asset: americanDollar, value: 126.78),
        .init(asset: euro, value: 2300.0),
        .init(asset: switzerlandFranc, value: 0.0),
        .init(asset: pancakeSwap, value: 10.34),
        .init(asset: polygon, value: 12.0)
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

struct Transaction {
    let assetName: String
    let value: Float
    let date: Date
    
    private static let DatesMock: [Date] = [
        "26/09/2022", "27/09/2022", "28/09/2022", "29/09/2022", "30/09/2022", "01/10/2022", "02/10/2022", "03/10/2022", "04/10/2022", "05/10/2022", "06/10/2022", "07/10/2022", "08/10/2022", "09/10/2022", "10/10/2022", "11/10/2022", "12/10/2022", "13/10/2022", "14/10/2022", "15/10/2022"
    ].compactMap { $0.date() }
    
    private static let TransactionsDetailsMock: [(String, Float)] = [
        ("USD", 2300.0),
        ("USD", -5.0),
        ("EUR", 219.23),
        ("BTC", 20.0),
        ("BTC", -20.0),
        ("ZL333", 34.5),
        ("EUR", -3.45),
        ("PLN", 2300),
        ("USD", 2200.1),
        ("EUR", 229.89),
        ("PLN", 456.78)
    ]
    
    static let TransactionsMock: [Transaction] = zip(TransactionsDetailsMock, DatesMock).map { (details, date) in
        let (assetName, value) = details
        return Transaction(assetName: assetName, value: value, date: date)
    }
}
