//
//  WalletViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 19/11/2022.
//

import Foundation

class WalletViewModel: ObservableObject {
    
    @Published var balances: [Wallet] = []
    
    private var service: any Service
    private var task: Task<(), Never>?
    
    init(service: any Service) {
        self.service = service
    }
    
    @MainActor func getWalletBalances(_ successCompletion: @escaping () -> Void,
                           _ failureCompletion: @escaping () -> Void) {
        task = Task {
            do {
                balances = try await service.getData() as! [Wallet]
                successCompletion()
            } catch {
                print("Error during fetching wallet balances: \(error.localizedDescription)")
                failureCompletion()
            }
        }
    }
}
