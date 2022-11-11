//
//  AssetDTO.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 09/11/2022.
//

import Foundation

struct AssetDTO: Decodable {
    let name: String
    let friendlyName: String
    let symbol: String?
    let category: String
}
