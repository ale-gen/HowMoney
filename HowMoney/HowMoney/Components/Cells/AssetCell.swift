//
//  AssetCell.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 16/10/2022.
//

import SwiftUI

struct AssetCell: View {
    
    private enum Constants {
        static let height: CGFloat = 110.0
        static let horizontalInsets: CGFloat = 20.0
        static let cornerRadius: CGFloat = 25.0
        
        enum Background {
            static let color: Color = .black.opacity(0.3)
            static let blurRadius: CGFloat = 5.0
        }
        enum Chart {
            static let trailingPadding: CGFloat = 15.0
            static let verticalPadding: CGFloat = 35.0
            static let maxWidth: CGFloat = 50.0
        }
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
    
    @StateObject var assetVM: AssetViewModel
    var additionalLabelColor: Color = .black
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Constants.Background.color)
                .background(.ultraThinMaterial)
                .blur(radius: Constants.Background.blurRadius)
            
            HStack {
                AssetInfoView(asset: assetVM.asset)
                
                Spacer()
                let color = assetVM.priceChange > .zero ? Constants.AdditionalInfo.increaseColor : (assetVM.priceChange < .zero ? Constants.AdditionalInfo.decreaseColor : Constants.AdditionalInfo.defaultColor)
                LineChart(data: assetVM.assetHistoryData.map { $0.value },  lineColor: color)
                    .frame(maxWidth: Constants.Chart.maxWidth)
                    .padding(.trailing, Constants.Chart.trailingPadding)
                    .padding(.vertical, Constants.Chart.verticalPadding)
                changeInfo(color: color)
            }
            .padding(.horizontal, Constants.horizontalInsets)
        }
        .contentShape(Rectangle())
        .frame(height: Constants.height)
        .cornerRadius(Constants.cornerRadius, [.allCorners])
        .onAppear {
            assetVM.getExchangeRateHistory({
                // print("Everything works great! ????")
            }, {
                // TODO: Show error toast
            })
        }
    }
    
    private func changeInfo(color: Color) -> some View { RoundedRectangle(cornerRadius: Constants.AdditionalInfo.cornerRadius)
            .frame(width: Constants.AdditionalInfo.width, height: Constants.AdditionalInfo.height)
            .foregroundColor(color)
            .opacity(Constants.AdditionalInfo.opacity)
            .overlay {
                HStack {
                    if let arrowImage = assetVM.assetPriceChangeImage {
                        arrowImage
                            .resizable()
                            .frame(width: Constants.AdditionalInfo.imageHeight, height: Constants.AdditionalInfo.imageHeight)
                    }
                    Text(String(format: "%.2f", abs(assetVM.percentagePriceChange)) + "%")
                        .font(Constants.AdditionalInfo.font)
                }
                .foregroundColor(color)
            }
    }
}

struct AssetCell_Previews: PreviewProvider {
    static var previews: some View {
        AssetCell(assetVM: AssetViewModel(asset: Asset.AssetsMock.first!))
    }
}
