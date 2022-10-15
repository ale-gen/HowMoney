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
    let asssetName: String
    let assetFriendlyName: String
    let assetType: AssetType
}
