//
//  KeyboardView.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 04/11/2022.
//

import SwiftUI

enum KeyboardButtonType: Hashable {
    case number(String)
    case clear(String)
    case decimalComma(String)
    
    var content: String {
        switch self {
        case .number(let string), .clear(let string), .decimalComma(let string):
            return string
        }
    }
}

struct KeyboardView: View {
    
    private enum Constants {
        enum Circle {
            static let padding: CGFloat = 50.0
            static let blur: CGFloat = 120.0
        }
        enum Rectangle {
            static let color: Color = .white.opacity(0.01)
            static let cornerRadius: CGFloat = 50.0
            static let roundedCorners: [UIRectCorner] = [.topLeft, .topRight]
        }
        enum StackView {
            static let spacing: CGFloat = 20.0
        }
        enum Button {
            static let font: Font = .system(size: 20.0)
            static let textColor: Color = .white
            static let maxHeight: CGFloat = 70.0
        }
    }
    
    let buttons: [[KeyboardButtonType]] = [
        [.number("1"), .number("2"), .number("3"), .clear("C")],
        [.number("4"), .number("5"), .number("6"), .number("0")],
        [.number("7"), .number("8"), .number("9"), .decimalComma(".")]
    ]
    
    @StateObject var vm: KeyboardViewModel
    @Binding var textValue: String
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Circle()
                    .fill(Color.lightBlue)
                    .padding(Constants.Circle.padding)
                    .blur(radius: Constants.Circle.blur)
                    .offset(x: -geo.size.width / 2, y: -geo.size.height / 5)
                
                Circle()
                    .fill(Color.lightGreen)
                    .padding(Constants.Circle.padding)
                    .blur(radius: Constants.Circle.blur)
                    .offset(x: geo.size.width / 2, y: geo.size.height / 5)
                
                Rectangle()
                    .fill(Constants.Rectangle.color)
                    .background(.ultraThinMaterial)
                    .ignoresSafeArea()
                    .cornerRadius(Constants.Rectangle.cornerRadius, Constants.Rectangle.roundedCorners)
                
                VStack(spacing: Constants.StackView.spacing) {
                    ForEach(buttons, id: \.self) { row in
                        HStack {
                            ForEach(row.indices, id: \.self) { index in
                                Button {
                                    vm.didTapButton(row[index])
                                    textValue = vm.textValue
                                } label: {
                                    Text(row[index].content)
                                        .font(Constants.Button.font)
                                        .foregroundColor(Constants.Button.textColor)
                                        .frame(width: (geo.size.width - (CGFloat(row.count - 1) * Constants.StackView.spacing)) / CGFloat(row.count))
                                        .frame(maxHeight: Constants.Button.maxHeight)
                                }
                            }
                        }
                    }
                }
                .frame(width: geo.size.width)
            }
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    
    @State static var value: String = .empty
    
    static var previews: some View {
        VStack {
            Text(value)
            KeyboardView(vm: KeyboardViewModel(assetType: .currency), textValue: $value)
                .frame(maxHeight: 300)
        }
    }
}
