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
        static let spacing: CGFloat = 2.0
        
        enum Title {
            static let font: Font = .caption2
            static let color: Color = .white
        }
        
        enum Subtitle {
            static let font: Font = .caption2
            static let color: Color = .gray
        }
        
        enum PreferenceCurrencyValue {
            static let font: Font = .caption2
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
            // TODO: asset image/symbol/flag
            
            VStack(alignment: .leading, spacing: Constants.spacing) {
                Text(userAsset.asset.friendlyName)
                    .font(Constants.Title.font)
                    .foregroundColor(Constants.Title.color)
                Text(userAsset.asset.name)
                    .font(Constants.Subtitle.font)
                    .foregroundColor(Constants.Subtitle.color)
            }
            
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
        .padding([.leading, .trailing], Constants.horizontalInsets)
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
