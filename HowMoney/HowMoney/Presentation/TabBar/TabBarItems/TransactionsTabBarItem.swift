//
//  TransactionsTabBarItem.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 23/10/2022.
//

import SwiftUI

struct TransactionsTabBarItem: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Transactions history tab bar item")
                .foregroundColor(.white)
            Spacer()
        }
    }
}

struct TransactionsTabBarItem_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsTabBarItem()
    }
}
