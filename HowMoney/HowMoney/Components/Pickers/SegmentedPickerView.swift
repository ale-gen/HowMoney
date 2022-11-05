//
//  SegmentedPickerView.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 05/11/2022.
//

import SwiftUI

struct SegmentedPickerView: View {
    
    private enum Constants {
        static let backgroundColor: Color = .lightBlue.opacity(0.2)
        static let selectedColor: Color = .lightBlue.opacity(0.8)
        static let height: CGFloat = 55.0
        static let blurRadius: CGFloat = 2.0
        static let spacing: CGFloat = 5.0
        static let namespaceId: String = "SegmentedPicker"
        static let animationDuration: CGFloat = 0.3
    }
    
    @State private var selection: Int = 0
    @Namespace var animation
    var items: [String]
    var didSelectItem: (Int) -> Void = { _ in }
    
    var selectedColor: Color?
    var font: Font?
    var fontWeight: Font.Weight?
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: Constants.spacing) {
                ForEach(items.indices, id: \.self) { index in
                    Button {
                        selection = index
                        didSelectItem(index)
                    } label: {
                        Text("\(items[index])")
                            .foregroundColor(.white)
                            .font(font ?? .subheadline)
                            .fontWeight(fontWeight ?? .semibold)
                            .contentShape(Rectangle())
                            .frame(width: (geo.size.width - (CGFloat(items.count - 1) * Constants.spacing)) / CGFloat(items.count))
                            .background(
                                Capsule()
                                    .fill(index == selection ? Constants.selectedColor : .clear)
                                    .frame(height: Constants.height)
                                    .conditionalModifier(index == selection) { $0.matchedGeometryEffect(id: Constants.namespaceId, in: animation)
                                    })
                            .animation(.easeIn(duration: Constants.animationDuration), value: selection)
                    }
                }
            }
            .frame(maxWidth: geo.size.width)
            .frame(height: geo.size.height)
            .background(
                Capsule()
                    .fill(selectedColor ?? Constants.backgroundColor)
                    .blur(radius: Constants.blurRadius)
            )
        }
        .frame(height: Constants.height)
        .padding()
    }
}

struct SegmentedPickerView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedPickerView(items: ["D", "W", "M", "6M", "Y"])
    }
}
