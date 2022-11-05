//
//  TransactionViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 05/11/2022.
//

import SwiftUI

class TransactionViewModel: ObservableObject {
    
    var asset: Asset
    var transaction: Transaction
    
    var transactionTypeColor: Color {
        return transaction.value > .zero ? .green : .red
    }
    
    var transactionTypeChar: String {
        return transaction.value > .zero ? .plus : .minus
    }
    
    init(transaction: Transaction, asset: Asset) {
        self.transaction = transaction
        self.asset = asset
    }
    
    
    
}
