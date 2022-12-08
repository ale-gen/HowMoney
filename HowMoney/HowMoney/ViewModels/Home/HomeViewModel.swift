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
    private var percentageChange: Double?
    private var profitTypeSubtitle: String?
    private var profit: Float?
    private var isIncreased: Bool?
    
    init(preferenceCurency: PreferenceCurrency) {
        self.preferenceCurrency = preferenceCurency
    }
    
    func prepareCardViewModels() -> [CardViewModel] {
        return walletBalances.map { wallet in
            countWalletChange(for: wallet)
            return CardViewModel(title: wallet.type.title,
                                 mainValue: Float(wallet.value),
                                 currency: preferenceCurrency,
                                 subtitle: profitTypeSubtitle,
                                 subValue: profit,
                                 additionalValue: percentageChange,
                                 isIncreased: isIncreased)
        }
    }
    
    private func countWalletChange(for wallet: Wallet) {
        guard let historyValues = wallet.historyValues else {
            resetChangesValues()
            return
        }
        guard historyValues.count >= 1 else {
            resetChangesValues()
            return
        }
        let currentValue = wallet.value
        var previousValue: Double
        if historyValues.count >= 6 {
            previousValue = historyValues[6]
            profitTypeSubtitle = Localizable.walletTotalBalanceWeeklyProfitSubtitle.value
        } else {
            previousValue = historyValues[0]
            profitTypeSubtitle = Localizable.walletTotalBalanceYeasterdaysProfitSubtitle.value
        }
        
        profit = Float(currentValue - previousValue)
        if previousValue == .zero || currentValue == .zero {
            percentageChange = 100
        } else if let profit = profit {
            percentageChange = Double(profit) / previousValue * 100
        }
        isIncreased = (profit ?? .zero) > .zero
    }
    
    private func resetChangesValues() {
        profit = nil
        profitTypeSubtitle = nil
        percentageChange = nil
        isIncreased = nil
    }
    
}
