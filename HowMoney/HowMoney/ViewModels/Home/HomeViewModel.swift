//
//  HomeViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 19/11/2022.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var walletBalances: [Wallet] = []
    @Published var alerts: [Alert] = []
    
    private(set) var preferenceCurrency: PreferenceCurrency
    private var percentageChange: Int?
    private var weeklyProfit: Float?
    private var isIncreased: Bool?
    
    init(preferenceCurency: PreferenceCurrency) {
        self.preferenceCurrency = preferenceCurency
    }
    
    func prepareCardViewModels() -> [CardViewModel] {
        walletBalances.map { wallet in
            countWeeklyChange(for: wallet)
            return CardViewModel(title: wallet.type.title,
                                 mainValue: Float(wallet.value),
                                 currency: preferenceCurrency,
                                 subtitle: wallet.type.subtitle,
                                 subValue: weeklyProfit,
                                 additionalValue: percentageChange,
                                 isIncreased: isIncreased)
        }
    }
    
    private func countWeeklyChange(for wallet: Wallet) {
        guard let historyValues = wallet.historyValues,
              let lastWeekValues = historyValues.count > 5 ? historyValues[..<6] : nil
        else {
            weeklyProfit = nil
            percentageChange = nil
            isIncreased = nil
            return
        }
        let latestValue = wallet.value
        let lastWeekValue = lastWeekValues.last ?? .zero
        
        weeklyProfit = Float(latestValue - lastWeekValue)
        percentageChange = Int(latestValue / lastWeekValue) * 100
        isIncreased = (weeklyProfit ?? .zero) > .zero
    }
    
}
