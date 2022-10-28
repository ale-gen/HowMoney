//
//  AssetsCollection.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 24/10/2022.
//

import SwiftUI

struct AssetsCollection: View {
    
    @StateObject var vm: AssetsViewModel = AssetsViewModel()
    
    var body: some View {
        ScrollView {
            ForEach(vm.assets, id: \.self) { asset in
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
