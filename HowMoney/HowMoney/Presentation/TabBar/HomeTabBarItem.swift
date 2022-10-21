//
//  HomeTabBarItem.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 18/10/2022.
//

import SwiftUI

struct HomeTabBarItem: View {
    
    private enum Constants {
        static let verticalInsets: CGFloat = 40.0
        static let maxHeight: CGFloat = 250.0
    }
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                CardCarousel(geo: geo)
            }
            .frame(maxHeight: Constants.maxHeight)
            Spacer()
        }
        .padding(.vertical, Constants.verticalInsets)
        .background(.black)
    }
}

struct HomeTabBarItem_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabBarItem()
    }
}
