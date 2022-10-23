//
//  WelcomeView.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 11/10/2022.
//

import SwiftUI

struct WelcomeView: View {
    
    private enum Constants {
        static let title: String = Localizable.welcomeSwipeToGetStarted.value
        static let sloganText: String = Localizable.welcomeCompanySloganText.value
        static let sliderColor: Color = .lightBlue
        static let backgroundColor: Color = .black
        static let sloganTextFont: Font = .subheadline
        static let sloganTextColor: Color = .white
        static let logoHeight: CGFloat = 110.0
        static let logoLeadingOffset: CGFloat = -50.0
        static let logoBottomOffset: CGFloat = -15.0
        static let slideButtonTopOffset: CGFloat = 30.0
        static let sliderWidthScaleMuliplier: CGFloat = 0.7
        static let bottomOffsetScaleMiltiplier: CGFloat = 0.05
    }
    
    var didGetStarted: (() -> Void)?
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Images.assetsBubbles.value
                    .resizable()
                    .scaledToFit()
                VStack {
                    Spacer()
                    Images.fullLogo.value
                        .resizable()
                        .scaledToFit()
                        .frame(height: Constants.logoHeight)
                        .padding(.bottom, Constants.logoBottomOffset)
                        .padding(.leading, Constants.logoLeadingOffset)
                    Text(Constants.sloganText)
                        .font(Constants.sloganTextFont)
                        .foregroundColor(Constants.sloganTextColor)
                    HStack {
                        Spacer()
                        SlideButton(title: Constants.title, sliderColor: Constants.sliderColor, width: geo.size.width * Constants.sliderWidthScaleMuliplier)
                            .onSwipeSuccess {
                                didGetStarted?()
                            }
                        Spacer()
                    }
                    .padding(.top, Constants.slideButtonTopOffset)
                }
                .padding(.bottom, geo.size.height * Constants.bottomOffsetScaleMiltiplier)
            }
        }
        .background(Constants.backgroundColor)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
