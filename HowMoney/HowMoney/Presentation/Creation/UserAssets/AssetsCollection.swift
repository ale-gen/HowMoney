//
//  AssetsCollection.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 24/10/2022.
//

import SwiftUI

struct AssetsCollection: View {
    
    @StateObject var vm: ListViewModel<Asset> = ListViewModel(items: Asset.AssetsMock)
    
    var body: some View {
        ScrollView {
            ForEach(vm.items, id: \.self) { asset in
                AssetCell(assetVM: AssetViewModel(asset: asset))
            }
        }
    }
}

struct AssetsCollection_Previews: PreviewProvider {
    static var previews: some View {
        AssetsCollection()
    }
}
