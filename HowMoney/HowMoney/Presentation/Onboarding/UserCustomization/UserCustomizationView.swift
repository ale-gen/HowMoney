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
            static let fontWeight: Font.Weight = .regular
            static let highlightFontWeight: Font.Weight = .heavy
            static let highlightColor: Color = .lightBlue
            static let color: Color = .white.opacity(0.9)
        }
        enum Button {
            static let topOffset: CGFloat = 20.0
        }
    }
    
    @StateObject var vm: UserCustomizationViewModel
    
    @StateObject private var toastVM: ToastViewModel = ToastViewModel.shared
    @State private var shouldNavigateToNextStep: Bool = false
    private let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing),
                                                        removal: .move(edge: .leading))
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                stepContent(for: vm.presentStep, imageHeight: geo.size.height / 2)
                    .animation(.default, value: vm.presentStep)
                    .transition(transition)
                
                RectangleButton(title: vm.presentStep.buttonTitle) {
                    vm.performNextStep( {
                        shouldNavigateToNextStep.toggle()
                    }, {
                        toastVM.show()
                    })
                }
                .padding(.vertical, Constants.Button.topOffset)
            }
        }
        .toast(shouldShow: $toastVM.isShowing, type: toastVM.toast.type, message: toastVM.toast.message)
        .navigate(destination: TabBarView(), when: $shouldNavigateToNextStep)
    }
    
    private var descriptionLabel: some View {
        vm.presentStep.description.split(separator: .space).map { String($0) }
            .reduce(Text(String.empty), {
                $0 + Text($1)
                    .foregroundColor(vm.presentStep.colorWordsDescription.contains($1) ? Constants.Description.highlightColor : Constants.Description.color)
                    .font(Constants.Description.font)
                    .fontWeight(vm.presentStep.colorWordsDescription.contains($1) ? Constants.Description.highlightFontWeight : Constants.Description.fontWeight)
                + Text(String.space)} )
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
    
    private func stepContent(for step: CustomizationStep, imageHeight: CGFloat) -> some View {
        VStack {
            step.image
                .resizable()
                .scaledToFit()
                .frame(maxHeight: imageHeight)
            Spacer()

            descriptionLabel
                .padding(.horizontal, Constants.horizontalPadding)

            Spacer()

            switch step {
            case .preferenceCurrency:
                preferenceCurrencyContent
            case .emailAlert:
                emailAlertsContent
            case .weeklyReports:
                weeklyReportsContent
            }
        }
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
