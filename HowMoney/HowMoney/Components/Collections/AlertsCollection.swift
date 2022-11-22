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
        
        enum Background {
            static let color: Color = .black
            static let cornerRadius: CGFloat = 15.0
        }
        enum Shadow {
            static let color: Color = .black.opacity(0.9)
            static let radius: CGFloat = 15.0
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm: ListViewModel<Alert>
    var didAlertDeleted: ((Alert, @escaping () -> Void) -> Void)?
    var scrollAxis: Axis.Set = .horizontal
    
    @State private var loaderView: LoaderView? = LoaderView()
    @State private var loading: Bool = false
    @State private var alertForDeletion: Alert?
    @State private var showConfirmationDialog: Bool = false
    
    var body: some View {
        if vm.items.count > .zero {
            ZStack {
                if scrollAxis == .vertical {
                    ZStack {
                        RoundedRectangle(cornerRadius: Constants.Background.cornerRadius)
                            .fill(Constants.Background.color)
                            .shadow(color: Constants.Shadow.color, radius: Constants.Shadow.radius)
                        
                        List(vm.items, id: \.self) { alert in
                            alertCell(alert)
                        }
                        .padding(.top, Constants.topOffset)
                    }
                } else {
                    ScrollView(scrollAxis, showsIndicators: false) {
                        HStack(spacing: Constants.spacing) {
                            ForEach(vm.items, id: \.self) { alert in
                                alertCell(alert)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(.black)
        } else {
            VStack {
                Spacer()
                AlertsEmptyState()
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    private func alertCell(_ alert: Alert) -> some View {
        AlertCell(alert: alert)
            .listRowBackground(Color.black)
            .frame(minWidth: Constants.minWidth)
            .conditionalModifier(scrollAxis == .vertical, { $0.swipeActions { deleteButton(alert) }
                  .confirmationDialog(Text(""), isPresented: $showConfirmationDialog) {
                        deleteConfirmationButton } message: {
                            deleteConfirmationMessage
                        }})
            
    }

    private func deleteButton(_ alert: Alert) -> some View {
        Button() {
            alertForDeletion = alert
            showConfirmationDialog = true
        } label: {
            Label(Localizable.deleteButtonTitle.value, systemImage: Icons.trash.rawValue)
        }
        .tint(.red)
    }
    
    private var deleteConfirmationButton: some View {
        Button(Localizable.deleteButtonTitle.value, role: .destructive) {
            print("🗑 Deleting...")
            withAnimation {
                guard let alertForDeletion = alertForDeletion else { return }
                didAlertDeleted?(alertForDeletion) {
                    ToastViewModel.shared.show()
                }
            }
        }
    }
    
    private var deleteConfirmationMessage: some View {
        Text(Localizable.alertsDeletionAlertMessage.value)
    }
}

struct AlertsCollection_Previews: PreviewProvider {
    static var previews: some View {
        AlertsCollection(vm: ListViewModel(service: AlertService()), scrollAxis: .horizontal)
    }
}
