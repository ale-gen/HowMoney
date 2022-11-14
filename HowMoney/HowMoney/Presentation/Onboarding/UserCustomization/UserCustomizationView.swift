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
        enum Button {
            static let topOffset: CGFloat = 20.0
        }
    }
    
    @StateObject var vm: UserCustomizationViewModel
    @State private var shouldNavigateToNextStep: Bool = false
    private let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing),
                                                        removal: .move(edge: .leading))
    
    var body: some View {
        GeometryReader { geo in
            VStack {
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
                }
                .transition(transition)
                
                RectangleButton(title: vm.presentStep.buttonTitle) {
                    vm.performNextStep( {
                        shouldNavigateToNextStep.toggle()
                    }, {
                        // TODO: Show error toast
                    })
                }
                .padding(.vertical, Constants.Button.topOffset)
                .animation(nil, value: vm.presentStep)
            }
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
    
    static var userStateVM: UserStateViewModel = UserStateViewModel()
    
    static var previews: some View {
        UserCustomizationView(vm: UserCustomizationViewModel(userStateVM: userStateVM))
            .environmentObject(userStateVM)
    }
}

struct UserCustomizationView_SmallerDevicePreviews: PreviewProvider {
    
    static var userStateVM: UserStateViewModel = UserStateViewModel()
    
    static var previews: some View {
        UserCustomizationView(vm: UserCustomizationViewModel(userStateVM: userStateVM))
            .environmentObject(userStateVM)
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
    }
}
