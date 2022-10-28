//
//  AssetsCollection.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 24/10/2022.
//

import SwiftUI

struct AssetsCollection: View {
    
    @StateObject var vm: AssetViewModel = AssetViewModel()
    
    var body: some View {
        ScrollView {
            ForEach(vm.assets, id: \.self) { asset in
                AssetCell(asset: asset, previousPrice: 4.69, actualPrice: 4.23)
            }
        }
    }
}

struct AssetsCollection_Previews: PreviewProvider {
    static var previews: some View {
        AssetsCollection()
    }
}
