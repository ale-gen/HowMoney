//
//  TransactionCell.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 05/11/2022.
//

import SwiftUI

struct TransactionCell: View {
    
    private enum Constants {
        enum General {
            static let horizontalInsets: CGFloat = 20.0
            static let height: CGFloat = 110.0
            static let cornerRadius: CGFloat = 20.0
        }
        enum ValueLabel {
            static let font: Font = .headline
        }
    }
    
    let vm: TransactionViewModel
    
    var body: some View {
        ZStack {
            GradientCell(gradientColor: vm.transactionTypeColor)
            
            HStack {
                AssetInfoView(asset: vm.asset)
                Spacer()
                valueLabel
                    .foregroundColor(vm.transactionTypeColor)
                    .font(Constants.ValueLabel.font)
            }
            .padding(.horizontal, Constants.General.horizontalInsets)
        }
        .frame(height: Constants.General.height)
        .cornerRadius(Constants.General.cornerRadius, [.allCorners])
    }
    
    private var valueLabel: some View {
        Text(vm.transactionTypeChar) + Text(" \(abs(vm.transaction.value), specifier: "%.\(vm.asset.type.decimalPlaces)f") ") + Text(vm.asset.symbol ?? .empty)
    }
}

struct TransactionCell_Previews: PreviewProvider {
    
    static let transaction = Transaction.TransactionsMock.first!
    
    static var previews: some View {
        TransactionCell(vm: TransactionViewModel(transaction: transaction, asset: Asset.AssetsMock.first(where: { asset in
            asset.name == transaction.assetName
        })!))
    }
}
