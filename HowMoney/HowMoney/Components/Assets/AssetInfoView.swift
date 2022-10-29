//
//  AssetInfoView.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 29/10/2022.
//

import SwiftUI

struct AssetInfoView: View {
    
    private enum Constants {
        static let height: CGFloat = 60.0
        static let spacing: CGFloat = 2.0
        enum Icon {
            static let height: CGFloat = Constants.height - 20.0
            static let trailingInset: CGFloat = 10.0
            static let shadow: CGFloat = 8.0
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

struct AssetInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AssetInfoView(asset: Asset.AssetsMock.first!)
    }
}
