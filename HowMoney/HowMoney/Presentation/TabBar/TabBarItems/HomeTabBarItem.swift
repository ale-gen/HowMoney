//
//  HomeTabBarItem.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 18/10/2022.
//

import SwiftUI

struct HomeTabBarItem: View {
    
    private enum Constants {
        static let verticalInsets: CGFloat = 20.0
        static let maxHeight: CGFloat = 250.0
        static let spacing: CGFloat = 10.0
        static let background: Color = .black
        
        enum Section {
            static let horizontalInsets: CGFloat = 2.0
            
            enum SupplementaryButton {
                static let color: Color = .lightBlue
            }
            enum Title {
                static let color: Color = .white.opacity(0.9)
                static let font: Font = .headline
            }
        }
    }
    
    @StateObject var homeVM: HomeViewModel = HomeViewModel(preferenceCurency: .eur)
    @StateObject var walletVM: WalletViewModel = WalletViewModel(service: Services.walletService)
    @StateObject var alertsVM: ListViewModel<Alert> = ListViewModel(service: Services.alertService)
    
    @State private var loaderView: LoaderView? = LoaderView()
    @State private var loading: Bool = false
    @State private var showAlertList: Bool = false
    
    var body: some View {
        VStack(spacing: Constants.spacing) {
            GeometryReader { geo in
                CardCarousel(geo: geo, cardViewModels: homeVM.prepareCardViewModels())
            }
            .frame(maxHeight: Constants.maxHeight)
            alertsSection
            Spacer()
        }
        .padding(.vertical, Constants.verticalInsets)
        .sheet(isPresented: $showAlertList) {
            NavigationView {
                AlertsCollection(vm: alertsVM, didAlertDeleted: alertsVM.deleteAlert, scrollAxis: .vertical)
                    .navigationTitle(Localizable.alertsCollectionTitle.value)
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
        .loader(loader: $loaderView, shouldHideLoader: $loading)
        .onAppear {
            loading = true
            let group = DispatchGroup()
            group.enter()
            walletVM.getWalletBalances({
                DispatchQueue.main.async {
                    homeVM.walletBalances = walletVM.balances
                }
                group.leave()
            }, {
                group.leave()
            })
            
            group.enter()
            alertsVM.getItems {
                group.leave()
            }
            
            group.notify(queue: .main) {
                loading = false
                print("✅ Wallet data and alerts are fetched!")
            }
        }
    }
    
    private var alertsSection: some View {
        section(title: Localizable.alertsCollectionTitle.value,
                content: AlertsCollection(vm: alertsVM))
    }
    
    private func section(title: String, content: some View) -> some View {
        VStack {
            HStack {
                Text(title)
                    .font(Constants.Section.Title.font)
                    .foregroundColor(Constants.Section.Title.color)
                Spacer()
                Button {
                    showAlertList = true
                } label: {
                    Text(Localizable.alertsCollectionSeeAllButtonTitle.value)
                        .foregroundColor(Constants.Section.SupplementaryButton.color)
                }
            }
            .padding()
            content
        }
        .padding(.horizontal, Constants.Section.horizontalInsets)
    }
}

struct HomeTabBarItem_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabBarItem()
            .environmentObject(UserStateViewModel())
    }
}
