//
//  AlertsEmptyState.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 25/10/2022.
//

import SwiftUI

struct AlertsEmptyState: View {
    
    let noAlertsModel = EmptyStateModel(image: Images.noAlerts.value,
                                        title: Localizable.alertsEmptyStateTitle.value,
                                        buttonTitle: Localizable.alertsCreateNewButtonTitle.value)
    @State private var shouldShowAlertCreationView: Bool = false
    
    var body: some View {
        EmptyStateView(model: noAlertsModel, didButtonTapped: {
            shouldShowAlertCreationView.toggle()
        })
        .sheet(isPresented: $shouldShowAlertCreationView) {
            NavigationView {
                CreationView(vm: AlertCreationViewModel(service: Services.alertService))
            }
        }
    }
}

struct AlertsEmptyState_Previews: PreviewProvider {
    static var previews: some View {
        AlertsEmptyState()
    }
}
