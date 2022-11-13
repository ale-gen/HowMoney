//
//  AssetHistoryDTO.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 13/11/2022.
//

import Foundation


struct AssetHistoryDTO: Decodable {
    let assetIdentifier: String
    let value: Float
}
