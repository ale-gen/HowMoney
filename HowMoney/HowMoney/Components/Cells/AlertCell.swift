//
//  AlertCell.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 25/10/2022.
//

import SwiftUI

struct AlertCell: View {
    
    private enum Constants {
        enum General {
            static let maxHeight: CGFloat = 150.0
            static let cornerRadius: CGFloat = 20.0
            static let contentInsets: CGFloat = 20.0
            static let color: Color = .blue
        }
        enum AssetTypeLabel {
            static let titleColor: Color = .white
            static let subtitleColor: Color = .white.opacity(0.6)
            static let titleFont: Font = .caption2
            static let subtitleFont: Font = .caption
            static let spacing: CGFloat = 2.0
        }
        enum Image {
            static let width: CGFloat = 25.0
            static let height: CGFloat = 25.0
        }
        enum TargetValueLabel {
            static let spacing: CGFloat = 5.0
            static let textSpecfier: String = "%.2f"
            static let fontColor: Color = .lightBlue
            static let font: Font = .headline
            static let titleColor: Color = .white
        }
    }
    
    let alert: Alert
    
    var body: some View {
        ZStack {
            GradientCell(gradientColor: Constants.General.color)
            
            VStack {
                HStack(alignment: .top) {
                    assetTypeLabel
                    Spacer()
                    alertImage
                }
                Spacer()
                HStack(alignment: .top) {
                    Text(alert.originAssetName)
                    Spacer()
                    targetValueLabel
                }
            }
            .padding(Constants.General.contentInsets)
        }
        .frame(maxHeight: Constants.General.maxHeight)
        .cornerRadius(Constants.General.cornerRadius, [.allCorners])
    }
    
    private var assetTypeLabel: some View {
        VStack(alignment: .leading, spacing: Constants.AssetTypeLabel.spacing) {
            Text(Localizable.alertsAssetTypeText.value)
                .foregroundColor(Constants.AssetTypeLabel.titleColor)
                .font(Constants.AssetTypeLabel.titleFont)
            Text(alert.originAssetType.name)
                .foregroundColor(Constants.AssetTypeLabel.subtitleColor)
                .font(Constants.AssetTypeLabel.subtitleFont)
        }
    }
    
    private var alertImage: some View {
        Images.alert.value
            .resizable()
            .scaledToFit()
            .frame(width: Constants.Image.width, height: Constants.Image.height)
    }
    
    private var targetValueLabel: some View {
        VStack(alignment: .trailing, spacing: Constants.TargetValueLabel.spacing) {
            Text(Localizable.alertsNotifyWhenText.value)
                .foregroundColor(Constants.TargetValueLabel.titleColor)
            Text("\(alert.targetValue, specifier: Constants.TargetValueLabel.textSpecfier) ") + Text(alert.targetCurrency.symbol)
        }
        .foregroundColor(Constants.TargetValueLabel.fontColor)
        .font(Constants.TargetValueLabel.font)
    }
}

struct AlertCell_Previews: PreviewProvider {
    static var previews: some View {
        AlertCell(alert: Alert.AlertsMock.first!)
    }
}
