//
//  TabBarView.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 23/10/2022.
//

import SwiftUI

struct TabBarView: View {
    
    @EnvironmentObject var userState: UserStateViewModel
    @StateObject var contentViewRouter: TabBarContentViewRouter = TabBarContentViewRouter()
    @State var selection: TabBarItem = .home
    @State var searchText: String = ""
    
    @StateObject private var toastVM: ToastViewModel = ToastViewModel.shared
    @State private var showCreationView: Bool = false
    @State private var selectedContext: CreationContext = .asset
    
    var body: some View {
        VStack {
            contentViewRouter.currentContent
            TabBar(tabs: [.home, .wallet, .plus, .transactions, .profile], selection: $selection, localSelection: selection, selectedContext: $selectedContext, showCreationView: $showCreationView)
        }
        .toast(shouldShow: $toastVM.isShowing, type: toastVM.toast.type, message: toastVM.toast.message)
        .onChange(of: selection) { newValue in
            contentViewRouter.navigateToContent(newValue)
        }
        .navigate(destination: selectedContext.destinationView,
                  when: $showCreationView,
                  hideNavBar: false,
                  destinationNavBarTitle: selectedContext.navBarTitle)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
            .environmentObject(UserStateViewModel())
    }
}

struct TabBarView_SmallerDevicePreviews: PreviewProvider {
    static var previews: some View {
        TabBarView()
            .environmentObject(UserStateViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
    }
}
