//
//  Asset.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 15/10/2022.
//

import Foundation

enum AssetType: String {
    case currency
    case cryptocurrency
    case metal
}

struct Asset {
    let assetId: String
    let assetName: String
    let assetFriendlyName: String
    let assetType: AssetType
    
    static let CurrencyAssetsMock: [Asset] = [
        .init(assetId: "1", assetName: "PLN", assetFriendlyName: "Polish Zloty", assetType: .currency),
        .init(assetId: "2", assetName: "USD", assetFriendlyName: "US Dollar", assetType: .currency),
        .init(assetId: "3", assetName: "EUR", assetFriendlyName: "Euro", assetType: .currency),
        .init(assetId: "4", assetName: "CHF", assetFriendlyName: "Swiss Franc", assetType: .currency),
        .init(assetId: "5", assetName: "AUD", assetFriendlyName: "Australian Dollar", assetType: .currency),
        .init(assetId: "6", assetName: "NPR", assetFriendlyName: "Nepalese rupee", assetType: .currency)
    ]
    
    static let CryptoAssetsMocks: [Asset]  = [
        .init(assetId: "1", assetName: "BTC", assetFriendlyName: "Bitcoin", assetType: .cryptocurrency),
        .init(assetId: "2", assetName: "CAKE", assetFriendlyName: "PancakeSWAP", assetType: .cryptocurrency),
        .init(assetId: "3", assetName: "MATIC", assetFriendlyName: "Polygon", assetType: .cryptocurrency),
        .init(assetId: "4", assetName: "ETH", assetFriendlyName: "Ethereum", assetType: .cryptocurrency),
        .init(assetId: "5", assetName: "USDC", assetFriendlyName: "USDC", assetType: .cryptocurrency),
        .init(assetId: "6", assetName: "USDT", assetFriendlyName: "Tether USD", assetType: .cryptocurrency)
    ]
    
    static let MetalAssetsMock: [Asset] = [
        .init(assetId: "1", assetName: "ZL333", assetFriendlyName: "Gold 333", assetType: .metal),
        .init(assetId: "2", assetName: "ZL900", assetFriendlyName: "Gold 900", assetType: .metal),
        .init(assetId: "3", assetName: "SR800", assetFriendlyName: "Silver 800", assetType: .metal),
        .init(assetId: "4", assetName: "SR925", assetFriendlyName: "Silver 925", assetType: .metal),
        .init(assetId: "5", assetName: "PL950", assetFriendlyName: "Platinium 950", assetType: .metal)
    ]
    
    static let AssetsMock: [Asset] = CurrencyAssetsMock + CryptoAssetsMocks + MetalAssetsMock
}

struct AssetHistoryRecord {
    let value: Float
    let date: Date
    
    private static let DatesMock: [Date] = [
        "26/09/2022", "27/09/2022", "28/09/2022", "29/09/2022", "30/09/2022", "01/10/2022", "02/10/2022", "03/10/2022", "04/10/2022", "05/10/2022", "06/10/2022", "07/10/2022", "08/10/2022", "09/10/2022", "10/10/2022", "11/10/2022", "12/10/2022", "13/10/2022", "14/10/2022", "15/10/2022"
    ].compactMap { $0.date() }
    
    private static let ValuesMock: [Float] = [
        4.9462, 4.9854, 4.9329, 4.9491, 4.9491, 4.9491, 4.9116, 4.8160, 4.8719, 4.9890, 4.9860, 4.9860, 4.9860, 5.0021, 4.9927, 4.9908, 4.9091, 4.9363
    ]
    
    static let DollarHistoryMock: [AssetHistoryRecord] = zip(ValuesMock, DatesMock).map { AssetHistoryRecord(value: $0, date: $1) }
}
