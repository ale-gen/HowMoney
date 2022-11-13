//
//  TransactionsEmptyState.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 14/11/2022.
//

import SwiftUI

struct TransactionsEmptyState: View {
    
    let noAlertsModel = EmptyStateModel(image: Images.noTransactions.value,
                                        title: Localizable.transactionsEmptyStateTitle.value,
                                        buttonTitle: .empty)
    
    var body: some View {
        EmptyStateView(model: noAlertsModel)
    }
}

struct TransactionsEmptyState_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsEmptyState()
    }
}
