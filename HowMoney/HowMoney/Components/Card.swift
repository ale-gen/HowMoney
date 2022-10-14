//
//  Card.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 12/10/2022.
//

import SwiftUI

struct Card: View {
    
    private enum Constants {
        enum General {
            static let height: CGFloat = 200.0
            static let horizontalInsets: CGFloat = 20.0
            static let spacing: CGFloat = 10.0
        }
        enum Rectangle {
            static let cornerRadius: CGFloat = 20.0
            static let opacity: CGFloat = 0.5
            static let color: Color = .black
        }
        enum Title {
            static let color: Color = .white
            static let font: Font = .system(size: 25.0, weight: .light)
            static let insets: UIEdgeInsets = UIEdgeInsets(top: -15.0, left: .zero, bottom: 20, right: .zero)
        }
        enum MainValue {
            static let color: Color = .white
            static let font: Font = .system(size: 30.0, weight: .bold)
        }
        enum Subtitle {
            static let color: Color = .white
            static let font: Font = .system(size: 15.0, weight: .light)
            static let bottomPadding: CGFloat = 1.0
        }
        enum SubValue {
            static let color: Color = .black
            static let font: Font = .system(size: 15.0, weight: .light)
        }
        enum Gradient {
            static let startRadius: CGFloat = 10.0
            static let endRadius: CGFloat = 220.0
        }
        enum AdditionalLabel {
            static let backgroundColor: Color = .black
            static let font: Font = SubValue.font
            static let color: Color = SubValue.color
            static let cornerRadius: CGFloat = 7.0
            static let opacity: CGFloat = 0.25
            static let width: CGFloat = 100.0
            static let height: CGFloat = 30.0
        }
        enum AdditionalStack {
            static let insets: UIEdgeInsets = UIEdgeInsets(top: 15, left: .zero, bottom: -15, right: .zero)
        }
    }
    
    let title: String
    let mainValue: Float
    let subtitle: String
    let subValue: Float
    let currency: PreferenceCurrency
    let additionalValue: Int
    let isIncreased: Bool
    
    var titleColor: Color = Constants.Title.color
    var mainValueColor: Color = Constants.MainValue.color
    var subtitleColor: Color = Constants.Subtitle.color
    var additionalLabelColor: Color = .black
    var gradientColors: [Color] = [.white, .black]
    
    var body: some View {
        ZStack {
            let radialGradient = RadialGradient(colors: gradientColors, center: .center, startRadius: Constants.Gradient.startRadius, endRadius: Constants.Gradient.endRadius)
            RoundedRectangle(cornerRadius: Constants.Rectangle.cornerRadius)
                .fill(radialGradient)
                .opacity(Constants.Rectangle.opacity)
            Spacer()
            VStack(alignment: .leading, spacing: Constants.General.spacing) {
                Text(title)
                    .foregroundColor(titleColor)
                    .font(Constants.Title.font)
                    .padding(.bottom, Constants.Title.insets.bottom)
                    .padding(.top, Constants.Title.insets.top)
                Text("\(currency.rawValue) \(mainValue)")
                    .foregroundColor(mainValueColor)
                    .font(Constants.MainValue.font)
                subtitleSection
            }
            .padding([.leading, .trailing], Constants.General.horizontalInsets)
        }
        .frame(height: Constants.General.height)
        .padding([.leading, .trailing], Constants.General.horizontalInsets)
    }
}

extension Card {
    
    private var subtitleSection: some View {
        HStack {
            VStack {
                Text(subtitle)
                    .foregroundColor(subtitleColor)
                    .font(Constants.Subtitle.font)
                    .padding(.bottom, Constants.Subtitle.bottomPadding)
                Text("\(isIncreased ? BalanceChar.positive.text : BalanceChar.negative.text) \(currency.rawValue) \(subValue)")
                    .foregroundColor(Constants.SubValue.color)
                    .font(Constants.SubValue.font)
            }
            Spacer()
            additionalLabel
        }
        .padding(.bottom, Constants.AdditionalStack.insets.bottom)
        .padding(.top, Constants.AdditionalStack.insets.top)
    }

    private var additionalLabel: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.AdditionalLabel.cornerRadius)
                .frame(width: Constants.AdditionalLabel.width, height: Constants.AdditionalLabel.height)
                .foregroundColor(Constants.Rectangle.color)
                .opacity(Constants.AdditionalLabel.opacity)
            HStack {
                isIncreased ? BalanceChar.positive.arrowImage : BalanceChar.negative.arrowImage
                Text("\(isIncreased ? BalanceChar.positive.text : BalanceChar.negative.text)\(additionalValue)%")
            }
            .foregroundColor(additionalLabelColor)
        }
        .padding(.bottom, Constants.AdditionalStack.insets.bottom)
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.red.ignoresSafeArea()
            Card(title: "Current Balance", mainValue: 12345.67, subtitle: "Monthly profit", subValue: 1262.5, currency: .usd, additionalValue: 28, isIncreased: true)
        }
        
    }
}
