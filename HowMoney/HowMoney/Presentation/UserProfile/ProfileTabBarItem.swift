//
//  ProfileTabBarItem.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 21/10/2022.
//

import SwiftUI

struct ProfileTabBarItem: View {
    
    private enum Constants {
        static let spacing: CGFloat = 20.0
        
        enum AvatarImage {
            static let width: CGFloat = 100.0
            static let height: CGFloat = 100.0
            static let shadowColor: Color = .pink.opacity(0.3)
            static let shadowRadius: CGFloat = 15.0
            static let topOffset: CGFloat = 40.0
        }
        enum NameLabel {
            static let color: Color = .white
            static let font: Font = .subheadline
        }
        enum Divider {
            static let color: Color = .white.opacity(0.8)
        }
    }
    
    @EnvironmentObject var authUserVM: UserStateViewModel
    @State var biometricsEnabled: Bool = false
    @State var weeklyReportsRequired: Bool = true
    @State var emailAlertsRequired: Bool = true
    
    var body: some View {
        ScrollView {
            VStack(spacing: Constants.spacing) {
                if let userAvatar = authUserVM.user?.picture {
                    avatarImage(userAvatar)
                }
                userNameLabel
                Divider().background(Constants.Divider.color)
                PreferenceCurrenciesCollection(selectedPreferenceCurrency: authUserVM.preferenceCurrency, didPreferenceCurrencyChanged: authUserVM.updateCurrencyPreference)
                toggleButtons
                RectangleButton(title: Localizable.authorizationSignOutButtonTitle.value, didButtonTapped: authUserVM.logout)
                    .padding(.bottom, 200)
            }
        }
    }
    
    private var userNameLabel: some View {
        HStack {
            Spacer()
            Text(authUserVM.user?.name ?? authUserVM.user?.nickname ?? .empty)
                .foregroundColor(Constants.NameLabel.color)
                .font(Constants.NameLabel.font)
            Spacer()
        }
        .padding(.bottom, Constants.spacing)
    }
    
    private var toggleButtons: some View {
        VStack {
            Divider().background(Constants.Divider.color)
            weeklyReports
            Divider().background(Constants.Divider.color)
            emailAlerts
            Divider().background(Constants.Divider.color)
            biometrics
        }
    }
    
    private var weeklyReports: some View {
        ToggleButton(isOn: $weeklyReportsRequired, textLabel: Localizable.userProfileWeeklyReportsLabelText.value)
    }
    
    private var emailAlerts: some View {
        ToggleButton(isOn: $emailAlertsRequired, textLabel: Localizable.userProfileEmailAlertsLabelText.value)
    }
    
    private var biometrics: some View {
        ToggleButton(isOn: $biometricsEnabled, textLabel: Localizable.userProfileBiometricsLabelText.value)
    }
    
    private func avatarImage(_ userAvatar: String) -> some View {
        AsyncImage(url: URL(string: userAvatar)) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
        .frame(width: Constants.AvatarImage.width, height: Constants.AvatarImage.height)
        .clipShape(Circle())
        .shadow(color: Constants.AvatarImage.shadowColor, radius: Constants.AvatarImage.shadowRadius)
        .padding(.top, Constants.AvatarImage.topOffset)
    }

}

struct ProfileTabBarItem_Previews: PreviewProvider {
    
    static var previews: some View {
        return Text("User cannot be fetch, please launch the app")
    }
}
