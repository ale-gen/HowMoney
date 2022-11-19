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
        guard let service = service as? WalletService else { return }
        task = Task {
            do {
                try await service.getWalletData { [weak self] in
                    self?.balances = $0
                }
                successCompletion()
            } catch {
                print("Error during fetching wallet balances: \(error.localizedDescription)")
                failureCompletion()
            }
        }
    }
}
