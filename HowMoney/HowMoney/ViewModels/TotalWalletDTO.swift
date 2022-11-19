//
//  TotalWalletDTO.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 19/11/2022.
//

import Foundation

struct TotalWalletDTO: Decodable {
    let totalValue: Double
    let currencyTotalValue: Double
    let cryptoTotalValue: Double
    let metalTotalValue: Double
}
