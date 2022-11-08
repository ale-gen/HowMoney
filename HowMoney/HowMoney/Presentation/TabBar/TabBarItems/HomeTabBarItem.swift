//
//  HomeTabBarItem.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 18/10/2022.
//

import SwiftUI

struct HomeTabBarItem: View {
    
    private enum Constants {
        static let verticalInsets: CGFloat = 20.0
        static let maxHeight: CGFloat = 250.0
        static let spacing: CGFloat = 20.0
        
        enum Section {
            static let horizontalInsets: CGFloat = 2.0
            
            enum SupplementaryButton {
                static let color: Color = .lightBlue
            }
            enum Title {
                static let color: Color = .white.opacity(0.9)
                static let font: Font = .headline
            }
        }
    }
    
    var alertsVM: ListViewModel<Alert> = ListViewModel(items: Alert.AlertsMock)
    
    var body: some View {
        VStack(spacing: Constants.spacing) {
            GeometryReader { geo in
                CardCarousel(geo: geo)
            }
            .frame(maxHeight: Constants.maxHeight)
            alertsSection
            Spacer()
        }
        .padding(.vertical, Constants.verticalInsets)
    }
    
    private var alertsSection: some View {
        section(title: Localizable.alertsCollectionTitle.value,
                content: AlertsCollection(vm: alertsVM))
    }
    
    private func section(title: String, content: some View) -> some View {
        VStack {
            HStack {
                Text(title)
                    .font(Constants.Section.Title.font)
                    .foregroundColor(Constants.Section.Title.color)
                Spacer()
                Button {
                    
                } label: {
                    Text(Localizable.alertsCollectionSeeAllButtonTitle.value)
                        .foregroundColor(Constants.Section.SupplementaryButton.color)
                }
            }
            .padding()
            content
        }
        .padding(.horizontal, Constants.Section.horizontalInsets)
    }
}

struct HomeTabBarItem_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabBarItem()
            .environmentObject(UserStateViewModel(authService: AuthorizationService()))
    }
}
