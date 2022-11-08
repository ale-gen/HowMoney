//
//  LoaderView.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 08/11/2022.
//

import SwiftUI

struct LoaderView: View {
    
    private enum Constants {
        static let width: CGFloat = 80.0
        static let height: CGFloat = 80.0
        static let animationDuration: CGFloat = 0.5
        static let yOffset: CGFloat = -50.0
    }
    
    @State private var animate: Bool = false
    
    var body: some View {
        ZStack {
            Spacer()
            Images.loader.value
                .resizable()
                .scaledToFit()
                .frame(width: Constants.width, height: Constants.height)
                .offset(y: animate ? Constants.yOffset : .zero)
                .animation(.easeInOut(duration: Constants.animationDuration).repeatForever(), value: animate)
            Spacer()
        }
        .onAppear {
            animate.toggle()
        }
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
