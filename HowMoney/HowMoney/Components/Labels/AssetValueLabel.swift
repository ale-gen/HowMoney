//
//  AssetValueLabel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 15/10/2022.
//

import SwiftUI

struct AssetValueLabel: View {
    
    private enum Constants {
        static let spacing: CGFloat = 1.0
    }
    
    let value: Float
    let symbol: String?
    let type: AssetType
    
    var body: some View {
        HStack(spacing: Constants.spacing) {
            Text(String(format: "%.\(type.decimalPlaces)f", value))
            Text(symbol ?? .empty)
        }
    }
}

struct AssetValueLabel_Previews: PreviewProvider {
    static var previews: some View {
        AssetValueLabel(value: 10.67, symbol: "zł", type: .currency)
    }
}
