//
//  UserAssetCreationView.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 29/10/2022.
//

import SwiftUI

struct UserAssetCreationView: View {
    
    @StateObject var vm: UserAssetCreationViewModel = UserAssetCreationViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let asset = vm.selectedAsset {
                    selectedAssetInfo(asset)
                } else {
                    assetSelectionButton
                }
                Spacer()
            }
        }
        
    }
    
    private var assetSelectionButton: some View {
        NavigationLink(destination: AssetsCollection(listViewModel: vm.prepareAssetsCollectionViewModel())) {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(Color.lightBlue.opacity(0.6))
                .frame(height: 100.0)
                .shadow(color: .lightBlue, radius: 10.0)
                .overlay {
                    HStack {
                        Text("Which asset would you like to add?")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.white)
                }
                .padding(.horizontal)
        }
    }
    
    private func selectedAssetInfo(_ asset: Asset) -> some View {
        VStack(alignment: .leading, spacing: 20.0) {
            Text("Selected asset:")
            AssetInfoView(asset: asset)
        }
    }
}

struct UserAssetCreationView_Previews: PreviewProvider {
    static var previews: some View {
        UserAssetCreationView()
    }
}
