//
//  AssetCell.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 16/10/2022.
//

import SwiftUI

struct AssetView: View {
    
    private enum Constants {
        static let height: CGFloat = 60.0
        static let spacing: CGFloat = 2.0
        enum Icon {
            static let height: CGFloat = Constants.height - 20.0
            static let trailingInset: CGFloat = 10.0
            static let shadow: CGFloat = 10.0
        }
        enum Title {
            static let font: Font = .system(size: 15.0, weight: .light)
            static let color: Color = .white
        }
        enum Subtitle {
            static let font: Font = .caption2
            static let color: Color = .gray
        }
    }
    
    let asset: Asset
    
    var body: some View {
        HStack {
            // TODO: asset image/symbol/flag
            Image("bitcoin")
                .resizable()
                .scaledToFit()
                .frame(width: Constants.Icon.height, height: Constants.Icon.height)
                .shadow(color: .orange, radius: Constants.Icon.shadow)
            
            VStack(alignment: .leading, spacing: Constants.spacing) {
                Text(asset.friendlyName)
                    .font(Constants.Title.font)
                    .foregroundColor(Constants.Title.color)
                Text(asset.name)
                    .font(Constants.Subtitle.font)
                    .foregroundColor(Constants.Subtitle.color)
            }
            .padding(.leading, Constants.Icon.trailingInset)
        }
    }
}

struct AssetCell: View {
    
    private enum Constants {
        static let height: CGFloat = 70.0
        static let horizontalInsets: CGFloat = 20.0
        
        enum AdditionalInfo {
            static let backgroundColor: Color = .black
            static let color: Color = .white
            static let font: Font = .system(size: 12.0)
            static let cornerRadius: CGFloat = 7.0
            static let opacity: CGFloat = 0.25
            static let width: CGFloat = 70.0
            static let height: CGFloat = 25.0
            static let imageHeight: CGFloat = height - 15
            static let insets: UIEdgeInsets = UIEdgeInsets(top: 15, left: .zero, bottom: -15, right: .zero)
            static let increaseColor: Color = .green
            static let decreaseColor: Color = .red
            static let defaultColor: Color = .white
        }
    }
    
    let asset: Asset
    let previousPrice: Float
    let actualPrice: Float
    var additionalLabelColor: Color = .black
    
    private var priceChange: Float {
        return actualPrice - previousPrice
    }
    
    private var percentagePriceChange: Float {
        return priceChange / previousPrice * 100
    }
    
    var body: some View {
        HStack {
            AssetView(asset: asset)
            
            Spacer()
            
            // TODO: Chart of history of asset
            let color = priceChange > .zero ? Constants.AdditionalInfo.increaseColor : (priceChange < .zero ? Constants.AdditionalInfo.decreaseColor : Constants.AdditionalInfo.defaultColor)
            changeInfo(color: color)
        }
        .frame(height: Constants.height)
        .padding([.leading, .trailing], Constants.horizontalInsets)
    }
    
    private func changeInfo(color: Color) -> some View { RoundedRectangle(cornerRadius: Constants.AdditionalInfo.cornerRadius)
            .frame(width: Constants.AdditionalInfo.width, height: Constants.AdditionalInfo.height)
            .foregroundColor(color)
            .opacity(Constants.AdditionalInfo.opacity)
            .overlay {
                HStack {
                    // TODO: Move logic to viewModel
                    if priceChange > .zero {
                        BalanceChar.positive.arrowImage
                            .resizable()
                            .frame(width: Constants.AdditionalInfo.imageHeight, height: Constants.AdditionalInfo.imageHeight)
                    } else if priceChange < .zero {
                        BalanceChar.negative.arrowImage
                            .resizable()
                            .frame(width: Constants.AdditionalInfo.imageHeight, height: Constants.AdditionalInfo.imageHeight)
                    }
                    Text(String(format: "%.2f", percentagePriceChange) + "%")
                        .font(Constants.AdditionalInfo.font)
                }
                .foregroundColor(color)
            }
    }
}

struct AssetCell_Previews: PreviewProvider {
    static var previews: some View {
        AssetCell(asset: Asset.AssetsMock.first!, previousPrice: 4.98, actualPrice: 4.98)
            .background(.black)
    }
}
