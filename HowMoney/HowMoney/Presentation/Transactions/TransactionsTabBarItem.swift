//
//  TransactionsTabBarItem.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 23/10/2022.
//

import SwiftUI

struct TransactionsTabBarItem: View {
    
    @StateObject var vm: TransactionsListViewModel = TransactionsListViewModel(service: AssetService())
    
    var body: some View {
        VStack {
            SegmentedPickerView(items: ["D", "W", "M", "6M", "Y"])
            
            if vm.items.count > .zero {
                ScrollView(showsIndicators: false) {
                    ForEach(vm.items, id: \.self) { transaction in
                        if let transactionVM = vm.prepareTransactionViewModel(for: transaction) {
                            TransactionCell(vm: transactionVM)
                        }
                    }
                }
                .padding()
            } else {
                VStack {
                    Spacer()
                    TransactionsEmptyState()
                    Spacer()
                }
            }
        }
    }
}

struct TransactionsTabBarItem_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsTabBarItem()
    }
}
