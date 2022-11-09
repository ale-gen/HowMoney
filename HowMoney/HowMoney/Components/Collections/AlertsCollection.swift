//
//  AlertsCollection.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 08/11/2022.
//

import SwiftUI

struct AlertsCollection: View {
    
    private enum Constants {
        static let spacing: CGFloat = 20.0
        static let minWidth: CGFloat = 250.0
    }
    
    @Environment(\.presentationMode) var presentationMode
    var vm: ListViewModel<Alert>
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Constants.spacing) {
                ForEach(vm.items, id: \.self) { alert in
                    AlertCell(alert: alert)
                        .frame(minWidth: Constants.minWidth)
                }
            }
        }
    }
}

struct AlertsCollection_Previews: PreviewProvider {
    static var previews: some View {
        AlertsCollection(vm: ListViewModel(service: AssetService()))
    }
}
