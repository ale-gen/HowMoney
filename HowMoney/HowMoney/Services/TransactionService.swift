//
//  TransactionService.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 16/11/2022.
//

import SwiftUI

class TransactionService: Service {
    
    typealias ServiceType = Transaction
    
    private let session = URLSession.shared
    private let baseUrlString = "\(String.baseUrl)\(NetworkEndpoints.transactions.rawValue)"
    
    func sendData(requestValues: RequestValues) async throws -> Transaction? {
        /* */
        return nil
    }
    
    func getData(_ parameters: Any...) async throws -> [Transaction] {
        guard let email = AuthUser.loggedUser?.email else { throw NetworkError.unauthorized }
        var urlString = baseUrlString
        for parameter in parameters {
            urlString += (parameter as? String) ?? .empty
        }
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        
        let token = try Keychain.get(account: email)
        let request = createRequest(url: url, token: token, method: .get)
        let (data, _) = try await session.data(for: request)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        guard let transactions = try? decoder.decode([TransactionDTO].self, from: data) else { throw NetworkError.invalidData }
        return transactions.map { Transaction.parse(from: $0) }.sorted(by: { $0.date > $1.date })
    }
    
    func updateData(_ model: Transaction) async throws -> Transaction? {
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
    
}



