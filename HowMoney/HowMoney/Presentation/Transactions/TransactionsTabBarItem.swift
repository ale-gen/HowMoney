//
//  TransactionsTabBarItem.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 23/10/2022.
//

import SwiftUI

struct TransactionsTabBarItem: View {
    
    private enum Constants {
        enum Animation {
            static let delay: CGFloat = 0.2
        }
    }
    
    @StateObject var vm: TransactionsListViewModel = TransactionsListViewModel(service: Services.transactionService)
    
    @State private var loaderView: LoaderView? = LoaderView()
    @State private var loading: Bool = false
    @State private var searchText: String = .empty
    
    var body: some View {
        VStack {
            SegmentedPickerView(items: TransactionDateRange.allCases.map { $0.shortName },
                                didSelectItem: vm.didDateRangeChanged)
            SearchBar(searchText: $searchText)
            
            if vm.items.count > .zero {
                ScrollView(showsIndicators: false) {
                    ForEach(vm.items.filter { vm.getAsset(for: $0)?.friendlyName.lowercased().contains(searchText.lowercased()) ?? true || searchText.isEmpty}) { transaction in
                        if let transactionVM = vm.prepareTransactionViewModel(for: transaction) {
                            TransactionCell(vm: transactionVM)
                        }
                    }
                }
                .padding()
            } else {
                VStack {
                    Spacer()
                    TransactionsEmptyState()
                    Spacer()
                }
            }
        }
        .loader(loader: $loaderView, shouldHideLoader: $loading)
        .onChange(of: vm.startDateRangeFormat, perform: { _ in
            self.loading = true
            vm.getTransactions {
                DispatchQueue.main.asyncAfter(deadline: .now() + Constants.Animation.delay) {
                    loading.toggle()
                }
            }
        })
        .onAppear {
            loading = true
            let group = DispatchGroup()
            group.enter()
            vm.getAssets({
                print("Assets are fetched in transactions list screen!")
                group.leave()
            })
            
            group.enter()
            vm.getTransactions({
                print("Transactions are fetched in transactions list screen!")
                group.leave()
            })
            
            group.notify(queue: .main) {
                DispatchQueue.main.asyncAfter(deadline: .now() + Constants.Animation.delay) {
                    loading.toggle()
                }
            }
        }
    }
}

struct TransactionsTabBarItem_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsTabBarItem()
    }
}
