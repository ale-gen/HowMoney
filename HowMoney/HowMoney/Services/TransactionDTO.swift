//
//  TransactionDTO.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 16/11/2022.
//

import Foundation

struct TransactionDTO: Decodable {
    let assetIdentifier: String
    let value: Float
    let timeStamp: Date
}
