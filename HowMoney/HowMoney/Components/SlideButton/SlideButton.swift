//
//  SlideButton.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 11/10/2022.
//

import SwiftUI

struct SlideButton: View {
    
    private enum Constants {
        enum General {
            static let height: CGFloat = 70.0
            static let horizontalInsets: CGFloat = 60.0
        }
        enum Title {
            static let fontColor: Color = .white
            static let offset: CGFloat = 30.0
        }
        enum Background {
            static let color: Color = .black
            static let opacity: CGFloat = 0.5
        }
        enum Slider {
            static let height: CGFloat = General.height - 10.0
            static let radius: CGFloat = 8.0
            static let fontColor: Color = .white
            static let imageName: String = "arrow.right"
        }
        enum Animation {
            static let responseTime: CGFloat = 0.2
            
        }
    }
    
    let title: String
    let sliderColor: Color
    let width: CGFloat
    var didSwipeFinished: (() -> Void)?
    @State private var sliderFinished: Bool = false
    @State private var swipeOffset: CGSize = .zero
    
    var body: some View {
        ZStack {
            Capsule()
                .frame(width: width, height: Constants.General.height)
                .foregroundColor(Constants.Background.color)
                .blendMode(.overlay)
                .opacity(Constants.Background.opacity)
            
            Text(title)
                .font(.callout)
                .foregroundColor(Constants.Title.fontColor)
                .offset(x: Constants.Title.offset, y: .zero)
            
            ZStack {
                Capsule()
                    .foregroundColor(sliderColor)
                    .frame(width: Constants.Slider.height + swipeOffset.width, height: Constants.Slider.height)
                    .shadow(color: sliderColor, radius: Constants.Slider.radius)
                
                Image(systemName: Constants.Slider.imageName)
                    .foregroundColor(Constants.Slider.fontColor)
                    .offset(x: swipeOffset.width / 2)
            }
            .offset(x: -(width / 2) + (Constants.Slider.height + swipeOffset.width + Constants.Slider.radius) / 2)
        }
        .animation(.spring(response: Constants.Animation.responseTime), value: swipeOffset)
        .gesture(
            DragGesture()
                .onChanged({ value in
                    self.handleDragGesture(value)
                })
                .onEnded({ value in
                    self.handleDragEnded(value)
                })
        )
    }
    
    func onSwipeSuccess(_ completion: @escaping () -> Void) -> Self {
        var this = self
        this.didSwipeFinished = completion
        return this
    }
    
    private func handleDragGesture(_ value: DragGesture.Value) {
        guard value.translation.width > 0 else { return }
        let totalSwipeWidth = width - Constants.Slider.height - Constants.Slider.radius
        if value.translation.width <= totalSwipeWidth {
            self.swipeOffset = value.translation
        } else if value.translation.width >= totalSwipeWidth {
            sliderFinished = true
            resetSliderOffset()
        }
    }
    
    private func handleDragEnded(_ value: DragGesture.Value) {
        if sliderFinished, let action = didSwipeFinished {
            action()
        }
        resetSliderOffset()
    }
    
    private func resetSliderOffset() {
        self.swipeOffset = .zero
    }
    
}

struct SlideButton_Previews: PreviewProvider {
    
    static var previews: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    SlideButton(title: "Swipe to get started", sliderColor: .green, width: geo.frame(in: .global).width * 0.7)
                    Spacer()
                }
            }
        }
        .padding(.bottom, 50)
        .background(.gray)
    }
}


