//
//  TransactionsListViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 05/11/2022.
//

import Foundation

class TransactionsListViewModel: ListViewModel<Transaction> {
    
    private var assets: [Asset] = []
    
    override init(service: (any Service)?) {
        super.init(service: service)
        fetchAssets()
    }
    
    func prepareTransactionViewModel(for transaction: Transaction) -> TransactionViewModel? {
        guard let asset = assets.first(where: { $0.name == transaction.assetName }) else {
            assertionFailure("Asset should be found")
            return nil
        }
        return TransactionViewModel(transaction: transaction, asset: asset)
    }
    
    private func fetchAssets() {
        assets = Asset.AssetsMock
    }
    
}
