//
//  UserAssetCell.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 15/10/2022.
//

import SwiftUI

struct UserAssetCell: View {
    
    private enum Constants {
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
    
    @EnvironmentObject var authUserVM: UserStateViewModel
    let userAsset: UserAsset
    
    var body: some View {
        HStack {
            AssetInfoView(asset: userAsset.asset)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: Constants.spacing) {
                AssetValueLabel(value: userAsset.originValue,
                                symbol: userAsset.asset.symbol,
                                type: userAsset.asset.type)
                    .font(Constants.PreferenceCurrencyValue.font)
                    .foregroundColor(Constants.PreferenceCurrencyValue.color)
                if userAsset.asset.name != authUserVM.localPreferenceCurrency.name {
                    PreferenceCurrencyValueLabel(value: userAsset.preferenceCurrencyValue)
                        .font(Constants.OriginValue.font)
                        .foregroundColor(Constants.OriginValue.color)
                } else { Text(verbatim: .empty) }
            }
        }
        .contentShape(Rectangle())
        .frame(height: Constants.height)
    }
}

struct UserAssetCell_Previews: PreviewProvider {
    
    static let userAssets: [UserAsset] = UserAsset.UserAssetsMock
    
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            UserAssetCell(userAsset: userAssets.first!)
                .environmentObject(UserStateViewModel())
        }
    }
}
