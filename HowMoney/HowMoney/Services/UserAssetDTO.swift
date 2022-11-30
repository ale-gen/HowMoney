//
//  UserAssetDTO.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 12/11/2022.
//

import Foundation

struct UserAssetDTO: Decodable {
    let asset: AssetDTO
    let originValue: Float
    let userCurrencyValue: Float
    let description: String
}
