//
//  AssetService.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 09/11/2022.
//

import Foundation

class AssetService: Service {
    
    private let session = URLSession.shared
    private let urlString = NetworkEndpoints.assets.rawValue
    
    typealias ServiceType = Asset
    
    func sendData() {
        /* */
    }
    
    func getData() async throws -> [Asset] {
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        let request = createRequest(url: url, method: .get)
        let (data, _) = try await session.data(for: request)
        guard let assets = try? JSONDecoder().decode([AssetDTO].self, from: data) else { throw NetworkError.invalidData }
        print(assets)
        return assets.map { Asset(id: $0.name, name: $0.name, friendlyName: $0.friendlyName, symbol: "fdsa", type: .currency)}
    }
    
    func updateData(_ model: Asset) -> Asset {
        /* */
        return Asset.AssetsMock.first!
    }
    
    func deleteData() -> Bool {
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
