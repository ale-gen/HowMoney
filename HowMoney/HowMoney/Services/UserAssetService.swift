//
//  UserAssetService.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 12/11/2022.
//

import SwiftUI

class UserAssetService: Service {
    
    typealias ServiceType = UserAsset
    
    private let session = URLSession.shared
    private let urlString = "\(String.baseUrl)\(NetworkEndpoints.userAssets.rawValue)"
    
    func sendData(requestValues: RequestValues) async throws -> UserAsset? {
        guard let email = AuthUser.loggedUser?.email else { throw NetworkError.unauthorized }
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        
        let token = try Keychain.get(account: email)
        let request = createRequest(url: url, token: token, method: .patch, body: requestValues.body)
        let (data, _) = try await session.data(for: request)
        guard let newUserAsset = try? JSONDecoder().decode([UserAssetDTO].self, from: data).first else { throw NetworkError.invalidData }
        return UserAsset.parse(from: newUserAsset)
    }
    
    func getData(_ parameters: Any...) async throws -> [UserAsset] {
        guard let email = AuthUser.loggedUser?.email else { throw NetworkError.unauthorized }
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        
        let token = try Keychain.get(account: email)
        let request = createRequest(url: url, token: token, method: .get)
        let (data, _) = try await session.data(for: request)
        guard let userAssets = try? JSONDecoder().decode([UserAssetDTO].self, from: data) else { throw NetworkError.invalidData }
        return userAssets.map { UserAsset.parse(from: $0) }
    }
    
    func updateData(_ model: UserAsset) async throws -> UserAsset? {
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


