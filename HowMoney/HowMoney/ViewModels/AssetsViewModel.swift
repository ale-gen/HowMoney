//
//  AssetsViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 27/10/2022.
//

import Foundation

class AssetsViewModel: ObservableObject {
    
    @Published var assets: [Asset] = []
    
    init() {
        assets = Asset.AssetsMock
    }
    
}
