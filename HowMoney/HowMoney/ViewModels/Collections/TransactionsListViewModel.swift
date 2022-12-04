//
//  TransactionsListViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 05/11/2022.
//

import Foundation

class TransactionsListViewModel: ListViewModel<Transaction> {
    
    @Published var assets: [Asset] = []
    @Published var startDateRangeFormat: String = "from=%@".localizedWithFormat(Date().today.textWithZone())
    
    private var assetTask: Task<(), Error>?
    private var transactionsTask: Task<(), Error>?
    private var endDateRangeFormat = "to=%@".localizedWithFormat(Date().today.textWithZone())
    
    override init(service: any Service) {
        super.init(service: service)
    }
    
    func prepareTransactionViewModel(for transaction: Transaction) -> TransactionViewModel? {
        guard let asset = assets.first(where: { $0.name == transaction.assetName }) else {
            assertionFailure("Asset should be found")
            return nil
        }
        return TransactionViewModel(transaction: transaction, asset: asset)
    }
    
    func getAsset(for transaction: Transaction) -> Asset? {
        return assets.first(where: { $0.name == transaction.assetName })
    }
    
    @MainActor func getAssets(_ completion: @escaping () -> Void) {
        assetTask = Task {
            do {
                self.assets = try await Services.assetService.getData()
                completion()
            } catch let error {
                print("Error during transactions fetching: \(error.localizedDescription)")
                completion()
            }
        }
    }
    
    func didDateRangeChanged(_ index: Int) {
        startDateRangeFormat = "from=%@".localizedWithFormat(TransactionDateRange.allCases[index].date.textWithZone())
    }
    
    @MainActor func getTransactions(_ completion: @escaping () -> Void) {
        let queryString = "?\(startDateRangeFormat)&\(endDateRangeFormat)"
        transactionsTask = Task {
            await getItems(completion, queryString)
        }
    }
    
}
