//
//  UserAssetsCollectionByAsset.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 02/12/2022.
//

import SwiftUI

struct UserAssetsCollectionByAsset: View {
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
        enum ArrowIcon {
            static let rotationDegrees: CGFloat = 90.0
        }
    }
    
    var items: Dictionary<Asset, ([UserAsset], Bool)>
    var didUserAssetDeleted: ((UserAsset, @escaping () -> Void) -> Void)?
    
    @State private var selectedAssetToExpand: Asset?
    
    var body: some View {
        if items.count > .zero {
            ZStack {
                background
                
                List(items.keys.sorted(by: { $0.friendlyName < $1.friendlyName })) { asset in
                    VStack {
                        groupingAssetCell(asset: asset)
                        .onTapGesture { changeExpandibility(for: asset) }
                        if selectedAssetToExpand == asset {
                            UserAssetsCollection(userAssets: (items[asset]?.0 ?? []).sorted(by: { $0.origin < $1.origin }), didUserAssetDeleted: didUserAssetDeleted)
                        }
                    }
                    .listRowBackground(Color.black)
                }
            }
        } else {
            VStack {
                Spacer()
                UserAssetEmptyState()
                Spacer()
            }
        }
    }
    
    private var background: some View {
        RoundedRectangle(cornerRadius: Constants.Background.cornerRadius)
            .fill(Constants.Background.color)
            .shadow(color: Constants.Shadow.color, radius: Constants.Shadow.radius)
    }
    
    private func groupingAssetCell(asset: Asset) -> some View {
        HStack {
            AssetInfoView(asset: asset)
            Spacer()
            Icons.rightArrow.value.rotationEffect(selectedAssetToExpand == asset ? Angle(degrees: Constants.ArrowIcon.rotationDegrees) : .zero)
        }
        .contentShape(Rectangle())
    }
    
    private func changeExpandibility(for asset: Asset) {
        if let _ = selectedAssetToExpand {
            selectedAssetToExpand = nil
        } else {
            selectedAssetToExpand = asset
        }
    }
}

struct UserAssetsCollectionByAsset_Previews: PreviewProvider {
    static var previews: some View {
        UserAssetsCollectionByAsset(items: [
            Asset.AssetsMock.first!: ([UserAsset.UserAssetsMock[2]], false),
            Asset.AssetsMock.last!: (UserAsset.UserAssetsMock, false)
        ])
        .environmentObject(UserStateViewModel())
    }
}
