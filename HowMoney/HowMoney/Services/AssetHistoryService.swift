//
//  AssetHistoryService.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 13/11/2022.
//

import SwiftUI

class AssetHistoryService: Service {
    
    typealias ServiceType = AssetHistoryRecord
    
    private let session = URLSession.shared
    private var baseUrlString = "\(String.baseUrl)\(NetworkEndpoints.assetHistory.rawValue)"
    
    func sendData(requestValues: RequestValues) async throws -> AssetHistoryRecord? {
        /* */
        return nil
    }
    
    func getData(_ parameters: Any...) async throws -> [AssetHistoryRecord] {
        guard let email = AuthUser.loggedUser?.email else { throw NetworkError.unauthorized }
        var urlString = baseUrlString
        for (index, parameter) in parameters.enumerated() {
            urlString += index == .zero ? "/" : "?"
            urlString += "\(parameter)"
        }
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        
        let token = try Keychain.get(account: email)
        let request = createRequest(url: url, token: token, method: .get)
        let (data, _) = try await session.data(for: request)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        guard let assetsHistory = try? decoder.decode([AssetHistoryDTO].self, from: data) else { throw NetworkError.invalidData }
        return assetsHistory.map { AssetHistoryRecord.parse(from: $0) }.sorted(by: { $0.date < $1.date })
    }
    
    func updateData(_ model: AssetHistoryRecord) async throws -> AssetHistoryRecord? {
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
    
    func resetPassword() async throws -> Bool {
        /* */
        return false
    }
    
}



