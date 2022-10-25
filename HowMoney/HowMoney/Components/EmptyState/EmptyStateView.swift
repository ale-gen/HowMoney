//
//  EmptyStateView.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 25/10/2022.
//

import SwiftUI

struct EmptyStateView: View {
    
    private enum Constants {
        static let spacing: CGFloat = 20.0
        
        enum Image {
            static let height: CGFloat = 160.0
            static let width: CGFloat = height
        }
        enum Title {
            static let color: Color = .gray.opacity(0.7)
            static let font: Font = .headline
        }
        enum Button {
            static let color: Color = .lightBlue
            static let font: Font = .callout
        }
    }
    
    let model: EmptyStateModel
    var didButtonTapped: (() -> Void)?
    
    var body: some View {
        VStack(spacing: Constants.spacing) {
            model.image
                .resizable()
                .scaledToFit()
                .frame(width: Constants.Image.width, height: Constants.Image.height)
            Text(model.title)
                .foregroundColor(Constants.Title.color)
                .font(Constants.Title.font)
            Button {
                // TODO: Navigate to new user asset or alert creation
                didButtonTapped?()
            } label: {
                Text(model.buttonTitle)
                    .foregroundColor(Constants.Button.color)
                    .bold()
                    .font(Constants.Title.font)
            }
        }
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView(model: EmptyStateModel(image: Images.noAssets.value, title: "No items", buttonTitle: "Create new item"))
    }
}
