//
//  Wallet.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 19/11/2022.
//

import Foundation

enum WalletType {
    case total
    case currency
    case crypto
    case metal
    
    var title: String {
        switch self {
        case .total:
            return Localizable.walletTotalBalanceTitle.value
        case .currency:
            return Localizable.walletCurrencyBalanceTitle.value
        case .crypto:
            return Localizable.walletCryptocurrencyBalanceTitle.value
        case .metal:
            return Localizable.walletMetalBalanceTitle.value
        }
    }
    
    var subtitle: String {
        switch self {
        case .total:
            return Localizable.walletTotalBalanceSubtitle.value
        case .currency, .crypto, .metal:
            return .empty
        }
    }
}

struct Wallet {
    let value: Double
    let type: WalletType
    let historyValues: [Double]?
    
    static func parse(from model: TotalWalletDTO) -> [Wallet] {
        return [Wallet(value: model.currencyTotalValue, type: .currency, historyValues: nil),
                Wallet(value: model.cryptoTotalValue, type: .crypto, historyValues: nil),
                Wallet(value: model.metalTotalValue, type: .metal, historyValues: nil)]
    }
    
    static func parse(from model: [WalletDTO]) -> Wallet? {
        guard !model.isEmpty,
              let latestValue = model.first?.value
        else { return nil }
        
        return Wallet(value: latestValue, type: .total, historyValues: [])
    }
}
