//
//  CardCarousel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 19/10/2022.
//

import SwiftUI

struct CardCarousel: View {
    
    private enum Constants {
        static let spacing: CGFloat = -40.0
        static let maxOffsetX: CGFloat = -1.0
    }
    
    var geo: GeometryProxy
    var cardViewModels: [CardViewModel]
    
    @State private var offsetX: CGFloat = 0.0
    @State private var maxOffsetX: CGFloat = Constants.maxOffsetX
    private var cardsNumber: CGFloat
    
    init(geo: GeometryProxy, cardViewModels: [CardViewModel]) {
        self.geo = geo
        self.cardViewModels = cardViewModels
        self.cardsNumber = CGFloat(cardViewModels.count)
    }
    
    var body: some View {
        let cardWidth: CGFloat = geo.size.width * 0.8
        let horizontalPadding: CGFloat = (geo.size.width - cardWidth) / 2
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: .zero) {
                GeometryReader { geo -> Color in
                    DispatchQueue.main.async {
                        let totalScrollViewWidth: CGFloat = cardWidth * cardsNumber * Constants.spacing * (cardsNumber - 1)
                        offsetX = (geo.frame(in: .global).minX - horizontalPadding) * (-1)
                        let maxOffsetX = totalScrollViewWidth - 2 * horizontalPadding - geo.size.width
                        if maxOffsetX == Constants.maxOffsetX {
                            self.maxOffsetX = maxOffsetX
                        }
                        
                    }
                    return Color.clear
                }
                .frame(width: .zero)
                
                HStack(spacing: Constants.spacing) {
                    ForEach(cardViewModels, id: \.self) { cardVM in
                        Card(title: cardVM.title, mainValue: cardVM.mainValue, subtitle: cardVM.subtitle, subValue: cardVM.subValue, currency: cardVM.currency, additionalValue: cardVM.additionalValue, isIncreased: cardVM.isIncreased, gradientColors: cardVM.gradientColors, screenWidth: geo.size.width, width: cardWidth)
                    }
                }
                .padding(.horizontal, horizontalPadding)
            }
        }
    }
    
    private func totalBalanceCard(width: CGFloat, screenWidth: CGFloat) -> some View {
        Card(title: "Total balance", mainValue: 123355, subtitle: "MonthlyProfit", subValue: 123, currency: .eur, additionalValue: 24, isIncreased: true, gradientColors: [.lightBlue, .lightGreen], screenWidth: screenWidth, width: width)
    }
    
    private func currencyBalanceCard(width: CGFloat, screenWidth: CGFloat) -> some View {
        Card(title: "Balance for currencies", mainValue: 123355, subtitle: "MonthlyProfit", subValue: 123, currency: .eur, additionalValue: 24, isIncreased: true, gradientColors: [.lightBlue, .lightGreen], screenWidth: screenWidth, width: width)
    }
    
    private func cryptoBalanceCard(width: CGFloat, screenWidth: CGFloat) -> some View {
        Card(title: "Balance for cryptos", mainValue: 123355, subtitle: "MonthlyProfit", subValue: 123, currency: .eur, additionalValue: 24, isIncreased: true, gradientColors: [.lightBlue, .lightGreen], screenWidth: screenWidth, width: width)
    }
    
    private func metalBalanceCard(width: CGFloat, screenWidth: CGFloat) -> some View {
        Card(title: "Balance for metals", mainValue: 123355, subtitle: "MonthlyProfit", subValue: 123, currency: .eur, additionalValue: 24, isIncreased: true, gradientColors: [.lightBlue, .lightGreen], screenWidth: screenWidth, width: width)
    }
    
}

struct CardCarousel_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            CardCarousel(geo: geo, cardViewModels: [])
        }
        .environmentObject(UserStateViewModel())
    }
}
