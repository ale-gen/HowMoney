//
//  AssetService.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 09/11/2022.
//

import SwiftUI

class AssetService: Service {
    
    typealias ServiceType = Asset
    
    private let session = URLSession.shared
    private let urlString = "\(NetworkEndpoints.assets.rawValue)"
    
    func sendData(requestValues: RequestValues) async throws -> Asset? {
        /* */
        return nil
    }
    
    func getData(_ parameters: Any...) async throws -> [Asset] {
        guard let email = AuthUser.loggedUser?.email else { throw NetworkError.unauthorized }
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        
        let token = try Keychain.get(account: email, service: "HowMoney")
        let request = createRequest(url: url, token: token, method: .get)
        let (data, _) = try await session.data(for: request)
        guard let assets = try? JSONDecoder().decode([AssetDTO].self, from: data) else { throw NetworkError.invalidData }
        return assets.map { Asset.parse(from: $0) }
    }
    
    func updateData(_ model: Asset) -> Asset? {
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
