//
//  ErrorToast.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 06/11/2022.
//

import SwiftUI

struct ToastView: View {
    
    private enum Constants {
        enum General {
            static let succesMaxHeight: CGFloat = 80.0
            static let errorMaxHeight: CGFloat = 100.0
            static let cornerRadius: CGFloat = 20.0
            static let closeIconColor: Color = .white
            static let bottomInsets: CGFloat = 20.0
        }
        enum Background {
            static let color: Color = Color.black.opacity(0.4)
            static let gradientStops: [Gradient.Stop] = [.init(color: .black.opacity(0.1), location: 0.1), .init(color: .black.opacity(0.8), location: 1.0)]
        }
        enum DecorationRectangle {
            static let width: CGFloat = 20.0
        }
        enum Stack {
            static let spacing: CGFloat = 7.0
            static let leadingOffset: CGFloat = 20.0
            static let titleColor: Color = .white
        }
    }
    
    @Binding var shouldBeVisible: Bool
    var toastType: ToastType
    var subtitle: String?
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Constants.Background.color)
                .background(.ultraThinMaterial)
            
            LinearGradient(stops: Constants.Background.gradientStops,
                           startPoint: .trailing,
                           endPoint: .leading)
            
            HStack {
                Rectangle()
                    .fill(toastType.color)
                    .background(.ultraThickMaterial)
                    .frame(width: Constants.DecorationRectangle.width)
                
                VStack(alignment: .leading, spacing: Constants.Stack.spacing) {
                    HStack {
                        toastType.icon
                            .foregroundColor(toastType.color)
                        Text(toastType.title)
                            .foregroundColor(Constants.Stack.titleColor)
                    }
                    Text(subtitle ?? .empty)
                        .foregroundColor(toastType.color)
                }
                .padding(.leading, Constants.Stack.leadingOffset)
                
                Spacer()
                VStack {
                    Icons.close.value
                        .foregroundColor(Constants.General.closeIconColor)
                        .padding()
                    Spacer()
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        shouldBeVisible = false
                    }
                }
            }
        }
        .frame(maxHeight: toastType == .success ? Constants.General.succesMaxHeight : Constants.General.errorMaxHeight)
        .cornerRadius(Constants.General.cornerRadius, [.allCorners])
        .padding(.bottom, Constants.General.bottomInsets)
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(shouldBeVisible: .constant(true),
                  toastType: .success,
                  subtitle: "Passwords have to be identical")
    }
}
