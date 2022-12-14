//
//  PreferenceCurrenciesCollection.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 23/10/2022.
//

import SwiftUI

struct PreferenceCurrenciesCollection: View {
    
    private enum Constants {
        static let verticalSpacing: CGFloat = 20.0
        static let horizontalSpacing: CGFloat = 10.0
        static let imageHeight: CGFloat = 40.0
        static let imageShadowColor: Color = .black.opacity(0.5)
        static let imageShadowRadius: CGFloat = 15.0
        static let textColor: Color = .white
        static let backgroundCornerRadius: CGFloat = 10.0
        static let nonSelectedCellColor: Color = .lightBlue.opacity(0.4)
        static let selectedCellColor: Color = .lightBlue
        static let backgroundShadowColor: Color = .lightBlue.opacity(0.7)
        static let backgroundShadowRadius: CGFloat = 12.0
    }
    
    var selectedPreferenceCurrency: PreferenceCurrency
    var shouldTitleVisible: Bool = true
    var didPreferenceCurrencyChanged: (PreferenceCurrency) -> Void = { _ in }
    
    var body: some View {
        VStack(spacing: Constants.verticalSpacing) {
            if shouldTitleVisible {
                HStack {
                    Text(Localizable.userProfilePreferenceCurrencyLabelText.value)
                        .foregroundColor(Constants.textColor)
                    Spacer()
                }
                .padding(.horizontal, Constants.horizontalSpacing)
            }
            preferenceCurrencies
        }
    }
    
    private var preferenceCurrencies: some View {
        let availableCurrencies: [PreferenceCurrency] = [.usd, .eur, .pln]
        return HStack(spacing: Constants.horizontalSpacing) {
            ForEach(availableCurrencies, id: \.self) { currency in
                Button {
                    withAnimation(.spring()) {
                        didPreferenceCurrencyChanged(currency)
                    }
                } label: {
                    preferenceCurrencyCell(for: currency)
                }
            }
        }
        .padding(.horizontal, 2 * Constants.horizontalSpacing)
    }
    
    private func preferenceCurrencyCell(for currency: PreferenceCurrency) -> some View {
        VStack(spacing: Constants.verticalSpacing) {
            currency.image
                .resizable()
                .scaledToFit()
                .frame(width: Constants.imageHeight, height: Constants.imageHeight)
                .shadow(color: Constants.imageShadowColor, radius: Constants.imageShadowRadius)
            
            HStack {
                Spacer()
                Text(currency.friendlyName)
                    .foregroundColor(Constants.textColor)
                Spacer()
            }
        }
        .padding(.vertical, Constants.verticalSpacing)
        .background(RoundedRectangle(cornerRadius: Constants.backgroundCornerRadius)
            .fill(currency == selectedPreferenceCurrency ? Constants.selectedCellColor : Constants.nonSelectedCellColor)
            .shadow(color: Constants.backgroundShadowColor, radius: currency == selectedPreferenceCurrency ? Constants.backgroundShadowRadius : .zero))
    }
}

struct PreferenceCurrenciesCollection_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceCurrenciesCollection(selectedPreferenceCurrency: .pln)
    }
}
