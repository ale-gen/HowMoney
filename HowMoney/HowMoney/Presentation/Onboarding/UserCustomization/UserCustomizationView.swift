//
//  UserCustomizationView.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 31/10/2022.
//

import SwiftUI

struct UserCustomizationView: View {
    
    private enum Constants {
        static let horizontalPadding: CGFloat = 10.0
        
        enum Description {
            static let font: Font = .subheadline
            static let color: Color = .white.opacity(0.9)
        }
    }
    
    @StateObject var vm: UserCustomizationViewModel = UserCustomizationViewModel()
    @State private var shouldNavigateToNextStep: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                vm.presentStep.image
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: geo.size.height / 2)
                
                Spacer()
                
                descriptionLabel
                
                Spacer()
                
                switch vm.presentStep {
                case .preferenceCurrency:
                    preferenceCurrencyContent
                case .emailAlert:
                    emailAlertsContent
                case .weeklyReports:
                    weeklyReportsContent
                }
                
                RectangleButton(title: vm.presentStep.buttonTitle) {
                    vm.performNextStep() {
                        shouldNavigateToNextStep.toggle()
                    }
                }
            }
            .transition(.asymmetric(insertion: .move(edge: .trailing),
                                    removal: .move(edge: .leading)))
        }
        .navigate(destination: TabBarView(), when: $shouldNavigateToNextStep)
    }
    
    private var descriptionLabel: some View {
        Text(vm.presentStep.description)
            .font(Constants.Description.font)
            .foregroundColor(Constants.Description.color)
            .padding(.horizontal, Constants.horizontalPadding)
    }
    
    private var preferenceCurrencyContent: some View {
        PreferenceCurrenciesCollection(selectedPreferenceCurrency: vm.chosenCurrency, shouldTitleVisible: false) { newValue in
            vm.choosePreferenceCurrency(newValue)
        }
    }
    
    private var emailAlertsContent: some View {
        ColorToggleButton(isOn: $vm.enabledEmailAlerts, textLabel: vm.presentStep.subtitle)
    }
    
    private var weeklyReportsContent: some View {
        ColorToggleButton(isOn: $vm.enabledWeeklyReports, textLabel: vm.presentStep.subtitle)
    }
}

struct UserCustomizationView_Previews: PreviewProvider {
    static var previews: some View {
        UserCustomizationView()
            .environmentObject(UserStateViewModel(authService: AuthorizationService()))
    }
}

struct UserCustomizationView_SmallerDevicePreviews: PreviewProvider {
    static var previews: some View {
        UserCustomizationView()
            .environmentObject(UserStateViewModel(authService: AuthorizationService()))
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
    }
}
