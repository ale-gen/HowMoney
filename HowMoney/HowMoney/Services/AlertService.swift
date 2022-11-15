//
//  AlertService.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 09/11/2022.
//

import Foundation

class AlertService: Service {
    
    typealias ServiceType = Alert
    
    private let session = URLSession.shared
    private let urlString = "\(String.baseUrl)\(NetworkEndpoints.alerts.rawValue)"
    
    func sendData(requestValues: RequestValues) async throws -> Alert? {
        guard let email = AuthUser.loggedUser?.email else { throw NetworkError.unauthorized }
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        
        let token = try Keychain.get(account: email)
        let request = createRequest(url: url, token: token, method: .post, body: requestValues.body)
        let (data, _) = try await session.data(for: request)
        guard let newAlert = try? JSONDecoder().decode(AlertDTO.self, from: data) else { throw NetworkError.invalidData }
        return Alert.parse(from: newAlert)
    }
    
    func getData(_ parameters: Any...) async throws -> [Alert] {
        guard let email = AuthUser.loggedUser?.email else { throw NetworkError.unauthorized }
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        
        let token = try Keychain.get(account: email)
        let request = createRequest(url: url, token: token, method: .get)
        let (data, _) = try await session.data(for: request)
        guard let alerts = try? JSONDecoder().decode([AlertDTO].self, from: data) else { throw NetworkError.invalidData }
        return alerts.map { Alert.parse(from: $0) }
    }
    
    func updateData(_ model: Alert) async throws -> Alert? {
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
