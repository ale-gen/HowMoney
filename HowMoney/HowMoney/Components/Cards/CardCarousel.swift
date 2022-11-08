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
        static let cardsNumber: CGFloat = 4
        static let maxOffsetX: CGFloat = -1.0
    }
    
    var geo: GeometryProxy
    
    @State private var offsetX: CGFloat = 0.0
    @State private var maxOffsetX: CGFloat = Constants.maxOffsetX
    private var cardsNumber: CGFloat
    
    init(geo: GeometryProxy) {
        self.geo = geo
        self.cardsNumber = Constants.cardsNumber
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
                    totalBalanceCard(width: cardWidth, screenWidth: geo.size.width)
                    currencyBalanceCard(width: cardWidth, screenWidth: geo.size.width)
                    cryptoBalanceCard(width: cardWidth, screenWidth: geo.size.width)
                    metalBalanceCard(width: cardWidth, screenWidth: geo.size.width)
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
            CardCarousel(geo: geo)
        }
        .environmentObject(UserStateViewModel(authService: AuthorizationService()))
    }
}
