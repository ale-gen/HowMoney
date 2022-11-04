//
//  AssetsCollection.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 24/10/2022.
//

import SwiftUI

struct AssetsCollection: View {
    
    @Environment(\.presentationMode) var presentationMode
    var vm: ListViewModel<Asset>
    
    init(listViewModel: ListViewModel<Asset>) {
        self.vm = listViewModel
    }
    
    var body: some View {
        ScrollView {
            ForEach(vm.items, id: \.self) { asset in
                AssetCell(assetVM: AssetViewModel(asset: asset))
                    .onTapGesture {
                        vm.didSelectItem(asset)
                        presentationMode.wrappedValue.dismiss()
                    }
            }
        }
    }
}

struct AssetsCollection_Previews: PreviewProvider {
    static var previews: some View {
        AssetsCollection(listViewModel: ListViewModel(items: Asset.AssetsMock))
    }
}
