//
//  AssetsCollection.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 24/10/2022.
//

import SwiftUI

struct AssetsCollection: View {
    
    private enum Constants {
        static let verticalInsets: CGFloat = 5.0
        enum Circle {
            static let opacity: CGFloat = 0.4
            static let blurRadius: CGFloat = 150.0
            static let offset: CGFloat = 100.0
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    var vm: ListViewModel<Asset>

    @State private var loaderView: LoaderView? = LoaderView()
    @State private var loading: Bool = false
    
    init(listViewModel: ListViewModel<Asset>) {
        self.vm = listViewModel
    }
    
    var body: some View {
        ZStack {
            backgroundCircles
            
            ScrollView(showsIndicators: false) {
                ForEach(vm.items, id: \.self) { asset in
                    AssetCell(assetVM: AssetViewModel(asset: asset))
                        .onTapGesture {
                            vm.didSelectItem(asset)
                            presentationMode.wrappedValue.dismiss()
                        }
                        .padding(.horizontal)
                        .padding(.vertical, Constants.verticalInsets)
                }
            }
        }
        .loader(loader: $loaderView, shouldHideLoader: $loading)
        .onAppear {
            vm.getItems {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    loading.toggle()
                }
            }
        }
    }
    
    private var backgroundCircles: some View {
        ZStack {
            Circle()
                .fill(Color.lightBlue.opacity(Constants.Circle.opacity))
                .blur(radius: Constants.Circle.blurRadius)
                .offset(x: -Constants.Circle.offset, y: -Constants.Circle.offset)
            
            Circle()
                .fill(Color.lightGreen.opacity(Constants.Circle.opacity))
                .blur(radius: Constants.Circle.blurRadius)
                .offset(x: Constants.Circle.offset, y: Constants.Circle.offset)
        }
    }
}

struct AssetsCollection_Previews: PreviewProvider {
    static var previews: some View {
        AssetsCollection(listViewModel: ListViewModel(service: AssetService()))
    }
}
