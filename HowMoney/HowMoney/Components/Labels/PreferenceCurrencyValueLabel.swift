//
//  PreferenceCurrencyValueLabel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 15/10/2022.
//

import SwiftUI

struct PreferenceCurrencyValueLabel: View {
    
    let value: Float
    // TODO: Update preference currency from user data
    let preferenceCurrency: PreferenceCurrency = .pln
    
    var body: some View {
        AssetValueLabel(value: value,
                        symbol: preferenceCurrency.symbol,
                        type: .currency)
    }
}

struct PreferenceCurrencyValueLabel_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceCurrencyValueLabel(value: 45.45)
    }
}
