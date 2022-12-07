//
//  UserAssetsCollection.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 16/10/2022.
//

import SwiftUI

struct UserAssetsCollection: View {
    
    private enum Constants {
        static let contentTrailingInsets: CGFloat = -40.0
        static let contentLeadingInsets: CGFloat = -30.0
        static let contentTopInsets: CGFloat = -10.0
        static let cellHeight: CGFloat = 90.0
    }
    
    @EnvironmentObject var userStateVM: UserStateViewModel
    let userAssets: [UserAsset]
    var didUserAssetDeleted: ((UserAsset, @escaping () -> Void) -> Void)?
    var refreshParentView: (() -> Void)?
    @State var selectedUserAsset: UserAsset?
    
    @State private var userAssetForDeletion: UserAsset?
    @State private var showConfirmationDialog: Bool = false
    
    var body: some View {
        if userAssets.count > .zero {
            ZStack {
                List(userAssets) { userAsset in
                    UserAssetCell(userAsset: userAsset, imageHidden: true)
                        .listRowBackground(Color.black)
                        .onTapGesture {
                            withAnimation {
                                selectedUserAsset = userAsset
                            }
                        }
                        .swipeActions { deleteButton(userAsset) }
                        .confirmationDialog(Text(String.empty), isPresented: $showConfirmationDialog) {
                            deleteConfirmationButton } message: {
                                deleteConfirmationMessage
                            }
                }
                .padding(.top, Constants.contentTopInsets)
                .padding(.trailing, Constants.contentTrailingInsets)
                .padding(.leading, Constants.contentLeadingInsets)
                .frame(maxWidth: .infinity)
                .frame(height: Constants.cellHeight * CGFloat(userAssets.count))
            }
            .sheet(item: $selectedUserAsset, onDismiss: {
                refreshParentView?()
            }) { userAsset in
                UserAssetDetailsView(vm: UserAssetViewModel(userAsset: userAsset, preferenceCurrency: userStateVM.localPreferenceCurrency))
            }
            .onAppear {
                userStateVM.getPreferences { /* */ }
            }
        } else {
            VStack {
                Spacer()
                UserAssetEmptyState()
                Spacer()
            }
        }
    }
    
    private func deleteButton(_ userAsset: UserAsset) -> some View {
        Button() {
            userAssetForDeletion = userAsset
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
                guard let userAssetForDeletion = userAssetForDeletion else { return }
                didUserAssetDeleted?(userAssetForDeletion) {
                    ToastViewModel.shared.show()
                }
            }
        }
    }
    
    private var deleteConfirmationMessage: some View {
        Text(Localizable.userAssetsDeletionAlertMessageTitle.value(userAssetForDeletion?.asset.friendlyName ?? .empty))
    }
}

struct UserAssetsCollection_Previews: PreviewProvider {
    static var previews: some View {
        UserAssetsCollection(userAssets: UserAsset.UserAssetsMock)
            .background(.black)
            .environmentObject(UserStateViewModel())
    }
}
