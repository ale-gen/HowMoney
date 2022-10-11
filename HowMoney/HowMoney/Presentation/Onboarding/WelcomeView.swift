//
//  WelcomeView.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 11/10/2022.
//

import SwiftUI

struct WelcomeView: View {
    
    private enum Constants {
        static let title: String = "Swipe to get started"
        static let sliderColor: Color = Color("lightPurple")
        static let backgroundColor: Color = .gray
        static let sliderWidthScaleMuliplier: CGFloat = 0.7
        static let bottomOffsetScaleMiltiplier: CGFloat = 0.1
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                HStack(alignment: .bottom) {
                    Spacer()
                    SlideButton(title: Constants.title, sliderColor: Constants.sliderColor, width: geo.size.width * Constants.sliderWidthScaleMuliplier)
                        .onSwipeSuccess {
                            // TODO: Navigate to login screen
                        }
                    Spacer()
                }
            }
            .padding(.bottom, geo.size.height * Constants.bottomOffsetScaleMiltiplier)
        }
        .background(Constants.backgroundColor)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
