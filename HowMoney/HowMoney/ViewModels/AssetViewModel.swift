//
//  AssetViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 27/10/2022.
//

import Foundation

class AssetViewModel: ObservableObject {
    
    @Published var assets: [Asset] = []
    
    init() {
        assets = Asset.AssetsMock
    }
    
}
