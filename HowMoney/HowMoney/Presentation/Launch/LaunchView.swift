//
//  LaunchView.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 27/11/2022.
//

import SwiftUI

struct LaunchView: View {
    
    private enum Constants {
        static let background: Color = .black
        static let animationLoopsNumber: Int = 2
        enum Logo {
            static let width: CGFloat = 160.0
            static let height: CGFloat = 160.0
        }
        enum Text {
            static let color: Color = .lightBlue
            static let offset: CGFloat = 60.0
            static let animatedOffset: CGFloat = -5.0
        }
        enum Timer {
            static let timeInterval: TimeInterval = 0.13
        }
    }
    
    @Binding var showLaunchScreen: Bool
    
    @State private var text: [String] = Localizable.launchScreenText.value.map { String($0) }
    @State private var showText: Bool = false
    @State private var animatedLetterIndex: Int = .zero
    private let timer = Timer.publish(every: Constants.Timer.timeInterval, on: .current, in: .common).autoconnect()
    @State private var currentLoopsNumber: Int = .zero
    
    var body: some View {
        ZStack {
            Constants.background
                .ignoresSafeArea()
            
            Images.appLogo.value
                .resizable()
                .frame(width: Constants.Logo.width, height: Constants.Logo.height)
            
            ZStack {
                HStack(spacing: .zero ) {
                    ForEach(text.indices, id: \.self) { letterIndex in
                        Text(text[letterIndex])
                            .foregroundColor(Constants.Text.color)
                            .fontWeight(.bold)
                            .offset(y: letterIndex == animatedLetterIndex ? Constants.Text.animatedOffset : .zero)
                    }
                }
            }
            .offset(y: Constants.Text.offset)
        }
        .onAppear {
            showText.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                animatedLetterIndex += 1
                if animatedLetterIndex % text.count == .zero {
                    animatedLetterIndex = 0
                    currentLoopsNumber += 1
                    if currentLoopsNumber == Constants.animationLoopsNumber {
                        showLaunchScreen.toggle()
                    }
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchScreen: .constant(true))
    }
}
