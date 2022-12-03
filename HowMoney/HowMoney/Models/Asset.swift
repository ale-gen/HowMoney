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
    
    var decimalPlaces: Int {
        switch self {
        case .currency:
            return 2
        case .cryptocurrency:
            return 8
        case .metal:
            return 8
        }
    }
    
    var name: String {
        switch self {
        case .currency:
            return Localizable.assetsCurrencyTypeName.value
        case .cryptocurrency:
            return Localizable.assetsCryptocurrencyTypeName.value
        case .metal:
            return Localizable.assetsMetalTypeName.value
        }
    }
}

struct Asset: Hashable {
    let name: String
    let friendlyName: String
    let symbol: String?
    let type: AssetType
    
    static func parse(from assetDto: AssetDTO) -> Asset {
        return Asset(name: assetDto.name, friendlyName: assetDto.friendlyName, symbol: assetDto.symbol, type: assetDto.category.lowercased().assetType())
    }
    
    static let CurrencyAssetsMock: [Asset] = [
        .init(name: "PLN", friendlyName: "Polish Zloty", symbol: "zł", type: .currency),
        .init(name: "USD", friendlyName: "US Dollar", symbol: "$", type: .currency),
        .init(name: "EUR", friendlyName: "Euro", symbol: "€", type: .currency),
        .init(name: "CHF", friendlyName: "Swiss Franc", symbol: "₣", type: .currency),
        .init(name: "AUD", friendlyName: "Australian Dollar", symbol: "$", type: .currency),
        .init(name: "NPR", friendlyName: "Nepalese rupee", symbol: "रु", type: .currency)
    ]
    
    static let CryptoAssetsMocks: [Asset]  = [
        .init(name: "BTC", friendlyName: "Bitcoin", symbol: nil, type: .cryptocurrency),
        .init(name: "CAKE", friendlyName: "PancakeSWAP", symbol: nil, type: .cryptocurrency),
        .init(name: "MATIC", friendlyName: "Polygon", symbol: nil, type: .cryptocurrency),
        .init(name: "ETH", friendlyName: "Ethereum", symbol: nil, type: .cryptocurrency),
        .init(name: "USDC", friendlyName: "USDC", symbol: nil, type: .cryptocurrency),
        .init(name: "USDT", friendlyName: "Tether USD", symbol: nil, type: .cryptocurrency)
    ]
    
    static let MetalAssetsMock: [Asset] = [
        .init(name: "ZL333", friendlyName: "Gold 333", symbol: nil, type: .metal),
        .init(name: "ZL900", friendlyName: "Gold 900", symbol: nil, type: .metal),
        .init(name: "SR800", friendlyName: "Silver 800", symbol: nil, type: .metal),
        .init(name: "SR925", friendlyName: "Silver 925", symbol: nil, type: .metal),
        .init(name: "PL950", friendlyName: "Platinium 950", symbol: nil, type: .metal)
    ]
    
    static let AssetsMock: [Asset] = CurrencyAssetsMock + CryptoAssetsMocks + MetalAssetsMock
}

struct AssetHistoryRecord: Hashable {
    
    let assetName: String
    let value: Float
    let date: Date
    
    static func parse(from assetHistory: AssetHistoryDTO) -> AssetHistoryRecord {
        AssetHistoryRecord(assetName: assetHistory.assetIdentifier, value: assetHistory.value, date: assetHistory.timeStamp)
    }
    
    static let DollarHistoryMock: [AssetHistoryRecord] = [
        4.9462, 4.9854, 4.9329, 4.9491, 4.9491, 4.9491, 4.9116, 4.8160, 4.8719, 4.9890, 4.9860, 4.9860, 4.9860, 5.0021, 4.9927, 4.9908, 4.9091, 4.9363, 4.5908, 4.6709
    ].map { AssetHistoryRecord(assetName: "USD", value: $0, date: Date().today) }
}
