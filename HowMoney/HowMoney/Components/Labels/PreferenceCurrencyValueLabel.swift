//
//  PreferenceCurrencyValueLabel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 15/10/2022.
//

import SwiftUI

struct PreferenceCurrencyValueLabel: View {
    
    @EnvironmentObject var authUserVM: UserStateViewModel
    let value: Float
    
    var body: some View {
        AssetValueLabel(value: value,
                        symbol: authUserVM.preferenceCurrency.symbol,
                        type: .currency)
    }
}

struct PreferenceCurrencyValueLabel_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceCurrencyValueLabel(value: 45.45)
    }
}
