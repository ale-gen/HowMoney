//
//  UserAssetsCollection.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 16/10/2022.
//

import SwiftUI

struct UserAssetsCollection: View {
    
    private enum Constants {
        static let horizontalInsets: CGFloat = 20.0
        static let contentHorizontalInsets: CGFloat = 10.0
        static let contentTopInsets: CGFloat = 20.0
        enum Background {
            static let color: Color = .black
            static let cornerRadius: CGFloat = 15.0
        }
        enum Shadow {
            static let color: Color = .black.opacity(0.9)
            static let radius: CGFloat = 15.0
        }
    }
    
    let userAssets: [UserAsset]
    var didUserAssetDeleted: ((UserAsset, @escaping () -> Void) -> Void)?
    @State var selectedUserAsset: UserAsset?
    @State private var userAssetForDeletion: UserAsset?
    @State private var showConfirmationDialog: Bool = false
    
    var body: some View {
        if userAssets.count > .zero {
            ZStack {
                RoundedRectangle(cornerRadius: Constants.Background.cornerRadius)
                    .fill(Constants.Background.color)
                    .shadow(color: Constants.Shadow.color, radius: Constants.Shadow.radius)
                
                List(userAssets) { userAsset in
                    UserAssetCell(userAsset: userAsset)
                        .listRowBackground(Color.black)
                        .onTapGesture {
                            withAnimation {
                                selectedUserAsset = userAsset
                            }
                        }
                        .swipeActions { deleteButton(userAsset) }
                        .confirmationDialog(Text(""), isPresented: $showConfirmationDialog) {
                            deleteConfirmationButton } message: {
                                deleteConfirmationMessage
                            }
                }
            }
            .sheet(item: $selectedUserAsset) { userAsset in
                UserAssetDetailsView(vm: UserAssetViewModel(userAsset: userAsset))
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
