//
//  AlertCell.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 25/10/2022.
//

import SwiftUI

struct AlertCell: View {
    
    let alert: Alert = Alert.AlertsMock.first!
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(Color.lightBlue)
                .shadow(color: .lightBlue, radius: 15)
            VStack(spacing: 20) {
                HStack(spacing: 20.0) {
                    VStack(alignment: .leading) {
                        Text("Alert on asset:")
                            .foregroundColor(.black)
                            .font(.subheadline)
                        Text(alert.originAssetName)
                            .foregroundColor(.secondary)
                            .font(.callout)
                    }
                    Divider().frame(width: 1.0).background(.gray.opacity(0.1))
                    
                    VStack(alignment: .trailing) {
                        Text("Currency type:")
                            .foregroundColor(.black)
                            .font(.subheadline)
                        Text(alert.originAssetType.name)
                            .foregroundColor(.secondary)
                            .font(.callout)
                    }
                }
                .frame(height: 60)
                Divider().background(.gray.opacity(0.1))
                Text("Notify when")
                    .foregroundColor(.black)
                    .font(.subheadline)
                HStack {
                    Text("1")
                    Text("$")
                    Text("=")
                    Text("\(alert.targetValue)")
                    Text(alert.targetCurrency.name)
                }
            }
        }
        .frame(height: 180)
        .padding(.horizontal, 20)
    }
}

struct AlertCell_Previews: PreviewProvider {
    static var previews: some View {
        AlertCell()
    }
}
