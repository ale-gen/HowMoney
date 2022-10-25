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
    
    var body: some View {
        EmptyStateView(model: noAlertsModel)
    }
}

struct AlertsEmptyState_Previews: PreviewProvider {
    static var previews: some View {
        AlertsEmptyState()
    }
}
