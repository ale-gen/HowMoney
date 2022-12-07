//
//  AlertDTO.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 15/11/2022.
//

import Foundation

struct AlertDTO: Decodable {
    let alertId: Int
    let value: Float
    let originAssetName: String
    let originAssetType: String
    let currency: String
    let active: Bool
}
