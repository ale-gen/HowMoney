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
    
    private let service: any Service
    private var previousPrice: Float?
    private var actualPrice: Float?
    private var task: Task<(), Never>?
    
    var priceChange: Float {
        guard let actualPrice = actualPrice,
                let previousPrice = previousPrice
        else { return .zero }
        return actualPrice - previousPrice
    }
    
    var percentagePriceChange: Float {
        guard let previousPrice = previousPrice else { return .zero }
        return priceChange / previousPrice * 100
    }
    
    init(asset: Asset) {
        self.service = Services.assetHistoryService
        self.asset = asset
    }
    
    @MainActor func getExchangeRateHistory(_ successCompletion: @escaping () -> Void,
                                           _ failureCompletion: @escaping () -> Void) {
        let startDateRangeParameter = "from=%@".localizedWithFormat(Date().previousMonth.textWithZone())
        task = Task {
            do {
                self.assetHistoryData = try await service.getData(asset.name.lowercased(), startDateRangeParameter) as! [AssetHistoryRecord]
                successCompletion()
            } catch let error {
                print("Error during \(asset.friendlyName)'s history fetching: \(error.localizedDescription)")
                failureCompletion()
            }
        }
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
