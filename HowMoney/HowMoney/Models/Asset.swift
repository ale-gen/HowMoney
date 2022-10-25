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
    let id: String
    let name: String
    let friendlyName: String
    let symbol: String?
    let type: AssetType
    
    static let CurrencyAssetsMock: [Asset] = [
        .init(id: "1", name: "PLN", friendlyName: "Polish Zloty", symbol: "zł", type: .currency),
        .init(id: "2", name: "USD", friendlyName: "US Dollar", symbol: "$", type: .currency),
        .init(id: "3", name: "EUR", friendlyName: "Euro", symbol: "€", type: .currency),
        .init(id: "4", name: "CHF", friendlyName: "Swiss Franc", symbol: "₣", type: .currency),
        .init(id: "5", name: "AUD", friendlyName: "Australian Dollar", symbol: "$", type: .currency),
        .init(id: "6", name: "NPR", friendlyName: "Nepalese rupee", symbol: "रु", type: .currency)
    ]
    
    static let CryptoAssetsMocks: [Asset]  = [
        .init(id: "7", name: "BTC", friendlyName: "Bitcoin", symbol: nil, type: .cryptocurrency),
        .init(id: "8", name: "CAKE", friendlyName: "PancakeSWAP", symbol: nil, type: .cryptocurrency),
        .init(id: "9", name: "MATIC", friendlyName: "Polygon", symbol: nil, type: .cryptocurrency),
        .init(id: "10", name: "ETH", friendlyName: "Ethereum", symbol: nil, type: .cryptocurrency),
        .init(id: "11", name: "USDC", friendlyName: "USDC", symbol: nil, type: .cryptocurrency),
        .init(id: "12", name: "USDT", friendlyName: "Tether USD", symbol: nil, type: .cryptocurrency)
    ]
    
    static let MetalAssetsMock: [Asset] = [
        .init(id: "13", name: "ZL333", friendlyName: "Gold 333", symbol: nil, type: .metal),
        .init(id: "14", name: "ZL900", friendlyName: "Gold 900", symbol: nil, type: .metal),
        .init(id: "15", name: "SR800", friendlyName: "Silver 800", symbol: nil, type: .metal),
        .init(id: "16", name: "SR925", friendlyName: "Silver 925", symbol: nil, type: .metal),
        .init(id: "17", name: "PL950", friendlyName: "Platinium 950", symbol: nil, type: .metal)
    ]
    
    static let AssetsMock: [Asset] = CurrencyAssetsMock + CryptoAssetsMocks + MetalAssetsMock
}

struct AssetHistoryRecord: Hashable {
    
    let date: Date
    let value: CGFloat
    
    init(date: Date, value: CGFloat) {
        self.date = date
        self.value = value
    }
    
    private static let DatesMock: [Date] = [
        "26/09/2022", "27/09/2022", "28/09/2022", "29/09/2022", "30/09/2022", "01/10/2022", "02/10/2022", "03/10/2022", "04/10/2022", "05/10/2022", "06/10/2022", "07/10/2022", "08/10/2022", "09/10/2022", "10/10/2022", "11/10/2022", "12/10/2022", "13/10/2022", "14/10/2022", "15/10/2022"
    ].compactMap { $0.date() }
    
    private static let ValuesMock: [CGFloat] = [
        4.9462, 4.9854, 4.9329, 4.9491, 4.9491, 4.9491, 4.9116, 4.8160, 4.8719, 4.9890, 4.9860, 4.9860, 4.9860, 5.0021, 4.9927, 4.9908, 4.9091, 4.9363, 4.5908, 4.6709
    ]
    
    static let DollarHistoryMock: [AssetHistoryRecord] = zip(DatesMock, ValuesMock).map { AssetHistoryRecord(date: $0, value: $1) }
}
