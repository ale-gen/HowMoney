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
            updateDailyPriceChangeImage()
        }
    }
    @Published var assetPriceChangeImage: Image? = nil
    @Published var assetDailyPriceChangeImage: Image? = nil
    
    private(set) var actualPrice: Float?
    private let service: any Service
    private var firstPrice: Float?
    private var previousDayPrice: Float?
    private var task: Task<(), Never>?
    
    var priceChange: Float {
        guard let actualPrice = actualPrice,
              let firstPrice = firstPrice
        else { return .zero }
        return actualPrice - firstPrice
    }
    
    var dailyPriceChange: Float {
        guard let actualPrice = actualPrice,
              let previousDayPrice = previousDayPrice
        else { return .zero }
        return actualPrice - previousDayPrice
    }
    
    var percentagePriceChange: Float {
        guard let firstPrice = firstPrice else { return .zero }
        return priceChange / firstPrice * 100
    }
    
    var dailyPercentagePriceChange: Float {
        guard let previousDayPrice = previousDayPrice else { return .zero }
        return dailyPriceChange / previousDayPrice * 100
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
        self.firstPrice = assetHistoryData.first?.value
        self.actualPrice = assetHistoryData.last?.value
        let prices = Array(assetHistoryData.suffix(2))
        self.previousDayPrice = prices.first?.value
    }
    
    private func updatePriceChangeImage() {
        guard let firstPrice = firstPrice,
              let actualPrice = actualPrice
        else { return }
        
        if actualPrice - firstPrice > .zero {
            assetPriceChangeImage = BalanceChar.positive.arrowImage
        } else if actualPrice - firstPrice < .zero {
            assetPriceChangeImage = BalanceChar.negative.arrowImage
        }
    }
    
    private func updateDailyPriceChangeImage() {
        guard let previousDayPrice = previousDayPrice,
              let actualPrice = actualPrice
        else { return }
        
        if actualPrice - previousDayPrice > .zero {
            assetDailyPriceChangeImage = BalanceChar.positive.arrowImage
        } else if actualPrice - previousDayPrice < .zero {
            assetDailyPriceChangeImage = BalanceChar.negative.arrowImage
        }
    }
    
}
