//
//  WalletService.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 19/11/2022.
//

import SwiftUI

class WalletService: Service {
    
    typealias ServiceType = Wallet
    
    private let session = URLSession.shared
    
    func sendData(requestValues: RequestValues) async throws -> Wallet? {
        /* */
        return nil
    }
    
    func getData(_ parameters: Any...) async throws -> [Wallet] {
        /* */
        return []
    }
    
    func getWalletData(completion: @escaping ([Wallet]) -> Void) async throws {
        let group = DispatchGroup()
        var balancesByType: [Wallet] = []
        var totalBalance: [Wallet] = []
        var balances: [Wallet] = []
        
        group.enter()
        balancesByType = try await getWalletBalances { group.leave() }
        
        group.enter()
        totalBalance = try await getTotalWalletHistory { group.leave() }
        
        group.notify(queue: .main) {
            print("✅ All data are fetched!")
            balances = totalBalance + balancesByType
            completion(balances)
        }
    }
    
    func updateData(_ model: Wallet) async throws -> Wallet? {
        /* */
        return nil
    }
    
    func deleteData(_ parameters: Any...) async throws -> Bool {
        /* */
        return false
    }
    
    func login(_ completion: @escaping (AuthUser) -> Void) {
        /* */
    }
    
    func logout(_ completion: @escaping () -> Void) {
        /* */
    }
    
    private func getWalletBalances(_ completion: () -> Void) async throws -> [Wallet] {
        guard let email = AuthUser.loggedUser?.email else { throw NetworkError.unauthorized }
        let urlString = "\(String.baseUrl)\(NetworkEndpoints.walletByAssetType.rawValue)"
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        
        let token = try Keychain.get(account: email)
        let request = createRequest(url: url, token: token, method: .get)
        let (data, _) = try await session.data(for: request)
        guard let walletBalances = try? JSONDecoder().decode(TotalWalletDTO.self, from: data) else {
            completion()
            print("🆘 Error during wallet balances fetching")
            throw NetworkError.invalidData
        }
        completion()
        return Wallet.parse(from: walletBalances)
    }
    
    private func getTotalWalletHistory(_ completion: () -> Void) async throws -> [Wallet] {
        guard let email = AuthUser.loggedUser?.email else { throw NetworkError.unauthorized }
        let urlString = "\(String.baseUrl)\(NetworkEndpoints.walletHistory.rawValue)?from=\(Date.now.previousWeek.text())"
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        
        let token = try Keychain.get(account: email)
        let request = createRequest(url: url, token: token, method: .get)
        let (data, _) = try await session.data(for: request)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        guard let totalBalance = try? decoder.decode([WalletDTO].self, from: data) else {
            completion()
            print("🆘 Error during total balance history fetching")
            throw NetworkError.invalidData
        }
        completion()
        return [Wallet.parse(from: totalBalance)].compactMap { $0 }
    }
}
