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
    private let dateFormatter: DateFormatter
    private var baseUrlString = "\(NetworkEndpoints.assetsHistory.rawValue)"
    
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    }
    
    func sendData(requestValues: RequestValues) async throws -> AssetHistoryRecord? {
        /* */
        return nil
    }
    
    func getData(_ parameters: Any...) async throws -> [AssetHistoryRecord] {
        guard let email = AuthUser.loggedUser?.email else { throw NetworkError.unauthorized }
        var urlString = baseUrlString
        for parameter in parameters {
            urlString += "/\(parameter)"
        }
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        
        let token = try Keychain.get(account: email, service: "HowMoney")
        let request = createRequest(url: url, token: token, method: .get)
        let (data, _) = try await session.data(for: request)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        guard let assetsHistory = try? decoder.decode([AssetHistoryDTO].self, from: data) else { throw NetworkError.invalidData }
        return assetsHistory.map { AssetHistoryRecord.parse(from: $0) }
    }
    
    func updateData(_ model: AssetHistoryRecord) -> AssetHistoryRecord? {
        /* */
        return nil
    }
    
    func deleteData(_ parameters: Any...) -> Bool {
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



