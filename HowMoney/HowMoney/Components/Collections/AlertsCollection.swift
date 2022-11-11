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
        static let topOffset: CGFloat = 20.0
    }
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm: ListViewModel<Alert>
    var scrollAxis: Axis.Set = .horizontal
    
    @State private var loaderView: LoaderView? = LoaderView()
    @State private var loading: Bool = false
    
    var body: some View {
        ScrollView(scrollAxis, showsIndicators: false) {
            if scrollAxis == .vertical {
                ZStack {
                    VStack(spacing: Constants.spacing) {
                        alertsCollectionContent
                    }
                    VStack {
                        Spacer()
                        LinearGradient(colors: [.white, .black],
                                       startPoint: .top,
                                       endPoint: .bottom)
                    }
                    .ignoresSafeArea()
                }
                .padding(.horizontal)
            } else {
                HStack(spacing: Constants.spacing) {
                    alertsCollectionContent
                }
            }
        }
        .conditionalModifier(scrollAxis == .vertical, { $0.padding(.top, Constants.topOffset) })
        .onAppear {
            vm.getItems {
                print("Alerts are fetched!")
            }
        }
    }
    
    private var alertsCollectionContent: some View {
        ForEach(vm.items, id: \.self) { alert in
            AlertCell(alert: alert)
                .frame(minWidth: Constants.minWidth)
        }
    }
}

struct AlertsCollection_Previews: PreviewProvider {
    static var previews: some View {
        AlertsCollection(vm: ListViewModel(service: AlertService()))
    }
}
