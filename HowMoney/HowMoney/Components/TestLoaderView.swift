//
//  TestLoaderView.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 08/11/2022.
//

import SwiftUI

class TestLoaderViewModel: ObservableObject {
    
    func getData(_ completion: @escaping () -> Void) {
        print("Fetching....")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completion()
        }
    }

}

struct TestLoaderView: View {

    @StateObject var vm: TestLoaderViewModel = TestLoaderViewModel()
    @State private var loaderView: LoaderView? = LoaderView()
    @State private var shouldHideLoader: Bool = true

    var body: some View {
        Text("Easy test on loader showing and hiding")
            .loader(loader: $loaderView, shouldHideLoader: $shouldHideLoader)
            .onAppear {
                shouldHideLoader = false
                vm.getData {
                    shouldHideLoader = true
                }
            }
    }
}

struct TestLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        TestLoaderView()
    }
}
