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
            static let color: Color = .white
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
            static let spacing: CGFloat = 2.0
            static let innerContainerHorizontalInset: CGFloat = -20.0
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
        enum Animation {
            static let damping: CGFloat = 4.5
            static let delay: CGFloat = 0.2
        }
    }
    
    let title: String
    let mainValue: Float
    let subtitle: String
    let subValue: Float
    let currency: PreferenceCurrency
    let additionalValue: Int
    let isIncreased: Bool
    
    var cardColor: Color?
    var titleColor: Color = Constants.Title.color
    var mainValueColor: Color = Constants.MainValue.color
    var subtitleColor: Color = Constants.Subtitle.color
    var additionalLabelColor: Color = .green
    var gradientColors: [Color] = [.lightBlue, .lightGreen]
    
    var screenWidth: CGFloat
    var width: CGFloat
    
    @State var cardOpacity: CGFloat = .invisibleAlpha
    
    var body: some View {
        GeometryReader { geo in
            let midX: CGFloat = geo.frame(in: .global).midX
            let distance: CGFloat = abs(screenWidth / 2 - midX)
            let damping: CGFloat = Constants.Animation.damping
            let percentage: CGFloat = abs(distance / (screenWidth / 2) / damping - 1)
            ZStack {
                let linearGradient = LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .leading, endPoint: .trailing)
                RoundedRectangle(cornerRadius: Constants.Rectangle.cornerRadius)
                    .fill(linearGradient)
                    .opacity(percentage)
                Spacer()
                VStack(alignment: .leading, spacing: Constants.General.spacing) {
                    Text(title)
                        .foregroundColor(titleColor)
                        .font(Constants.Title.font)
                        .padding(.bottom, Constants.Title.insets.bottom)
                        .padding(.top, Constants.Title.insets.top)
                    PreferenceCurrencyValueLabel(value: mainValue)
                        .foregroundColor(mainValueColor)
                        .font(Constants.MainValue.font)
                    subtitleSection
                }
                .padding(.horizontal, Constants.General.horizontalInsets)
            }
            .scaleEffect(percentage)
            .opacity(percentage)
        }
        .frame(width: width, height: Constants.General.height)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.Animation.delay) {
                withAnimation {
                    cardOpacity = .visibleAlpha
                }
            }
        }
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
                HStack(spacing: Constants.SubValue.spacing) {
                    Text("\(isIncreased ? BalanceChar.positive.text : BalanceChar.negative.text)")
                    PreferenceCurrencyValueLabel(value: subValue)
                }
                .padding(.leading, Constants.SubValue.innerContainerHorizontalInset)
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
        Card(title: "Current Balance", mainValue: 12345.67, subtitle: "Monthly profit", subValue: 1262.5, currency: .usd, additionalValue: 28, isIncreased: true, screenWidth: UIScreen.main.bounds.width * 0.9, width: UIScreen.main.bounds.width * 0.8)
            .environmentObject(UserStateViewModel())
    }
}
