//
//  AssetViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 28/10/2022.
//

import SwiftUI


class AssetViewModel: ObservableObject {
    
    @Published var asset: Asset
    @Published var assetHistoryData: [AssetHistoryRecord] = [] {
        didSet {
            extractLastPrices()
            updatePriceChangeImage()
        }
    }
    @Published var assetPriceChangeImage: Image? = nil
    
    private var previousPrice: CGFloat?
    private var actualPrice: CGFloat?
    
    var priceChange: CGFloat {
        guard let actualPrice = actualPrice,
                let previousPrice = previousPrice
        else { return .zero }
        return actualPrice - previousPrice
    }
    
    var percentagePriceChange: CGFloat {
        guard let previousPrice = previousPrice else { return .zero }
        return priceChange / previousPrice * 100
    }
    
    init(asset: Asset) {
        self.asset = asset
        self.assetHistoryData = AssetHistoryRecord.DollarHistoryMock
    }
    
    private func extractLastPrices() {
        let prices = Array(assetHistoryData.suffix(2))
        self.previousPrice = prices.first?.value
        self.actualPrice = prices.last?.value
    }
    
    private func updatePriceChangeImage() {
        guard let previousPrice = previousPrice,
              let actualPrice = actualPrice
        else { return }
        
        if actualPrice - previousPrice > .zero {
            assetPriceChangeImage = BalanceChar.positive.arrowImage
        } else if actualPrice - previousPrice < .zero {
            assetPriceChangeImage = BalanceChar.negative.arrowImage
        }
    }
    
}
