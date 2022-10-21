//
//  UserAssetCell.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 15/10/2022.
//

import SwiftUI

struct UserAssetCell: View {
    
    private enum Constants {
        static let horizontalInsets: CGFloat = 20.0
        static let height: CGFloat = 60.0
        static let spacing: CGFloat = 2.0
        
        enum PreferenceCurrencyValue {
            static let font: Font = .system(size: 15.0, weight: .light)
            static let color: Color = .white
        }
        
        enum OriginValue {
            static let font: Font = .caption2
            static let color: Color = .gray
        }
    }
    
    let userAsset: UserAsset
    // TODO: Fetch real preference currency for user
    let preferenceCurrency: PreferenceCurrency = .pln
    
    var body: some View {
        HStack {
            AssetView(asset: userAsset.asset)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: Constants.spacing) {
                AssetValueLabel(value: userAsset.originValue,
                                symbol: userAsset.asset.symbol,
                                type: userAsset.asset.type)
                    .font(Constants.PreferenceCurrencyValue.font)
                    .foregroundColor(Constants.PreferenceCurrencyValue.color)
                if userAsset.asset.name != preferenceCurrency.name {
                    PreferenceCurrencyValueLabel(value: userAsset.preferenceCurrencyValue)
                        .font(Constants.OriginValue.font)
                        .foregroundColor(Constants.OriginValue.color)
                } else { Text(verbatim: .empty) }
            }
        }
        .frame(height: Constants.height)
        .padding(.horizontal, Constants.horizontalInsets)
    }
}

struct UserAssetCell_Previews: PreviewProvider {
    
    static let userAssets: [UserAsset] = UserAsset.UserAssetsMock
    
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            UserAssetCell(userAsset: userAssets.first!)
        }
    }
}
