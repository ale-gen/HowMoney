//
//  AuthorizationService.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 22/10/2022.
//

import Foundation
import Auth0

struct AuthorizationService: Service {
    
    typealias ServiceType = UserPreferences
    
    private let session = URLSession.shared
    private let urlString = "\(String.baseUrl)\(NetworkEndpoints.userPreferences.rawValue)"
    
    func login(_ completion: @escaping (AuthUser) -> Void) {
        let credentialsManager = CredentialsManager(authentication: Auth0.authentication())
        guard !credentialsManager.hasValid() && !credentialsManager.canRenew() else {
            credentialsManager.credentials { result in
                switch result {
                case .success(let credentials):
                    authenticateUser(with: credentials, completion)
                case .failure(let error):
                    print("❌ Cannot authenticate recent user because of error: \(error)")
                }
            }
            return
        }
        Auth0
            .webAuth()
            .parameters(["prompt": "login"])
            .audience(extractAudienceValue() ?? .empty)
            .start { result in
                switch result {
                case let .success(credentials):
                    guard credentialsManager.store(credentials: credentials) else { return }
                    authenticateUser(with: credentials, completion)
                case let .failure(error):
                    print("❌ Cannot authenticate new user because of error: \(error)")
                }
            }
    }
    
    func logout(_ completion: @escaping () -> Void) {
        Keychain.logout()
        completion()
    }
    
    func getData(_ parameters: Any...) async throws -> [UserPreferences] {
        guard let email = AuthUser.loggedUser?.email else { throw NetworkError.unauthorized }
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        
        let token = try Keychain.get(account: email)
        let request = createRequest(url: url, token: token, method: .get)
        let (data, _) = try await session.data(for: request)
        guard let userPreferences = try? JSONDecoder().decode(UserPreferencesDTO.self, from: data) else { throw NetworkError.invalidData }
        return [UserPreferences.parse(from: userPreferences)]
    }
    
    func sendData(requestValues: RequestValues) async throws -> UserPreferences? {
        guard let email = AuthUser.loggedUser?.email else { throw NetworkError.unauthorized }
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        
        let token = try Keychain.get(account: email)
        let request = createRequest(url: url, token: token, method: .put, body: requestValues.body)
        let (data, _) = try await session.data(for: request)
        guard let newPreferences = try? JSONDecoder().decode(UserPreferencesDTO.self, from: data) else { throw NetworkError.invalidData }
        return UserPreferences.parse(from: newPreferences)
    }
    
    func updateData(_ model: UserPreferences) async throws -> UserPreferences? { return nil }
    func deleteData(_ parameters: Any...) async throws -> Bool { return false }
    
    private func extractAudienceValue() -> String? {
        guard let path = Bundle.main.path(forResource: "Auth0", ofType: "plist"),
              let values = NSDictionary(contentsOfFile: path) as? [String: Any],
              let audience = values["Audience"] as? String
        else { return nil }
        
        return audience
    }
    
    private func saveToken(_ accessToken: String, for user: AuthUser) -> Bool {
        do {
            try Keychain.save(account: user.email, token: accessToken)
            return true
        } catch {
            print("⚠️ Token wasn't saved")
            return false
        }
    }
    
    private func authenticateUser(with credentials: Credentials, _ completion: @escaping (AuthUser) -> Void) {
        guard let user = AuthUser(from: credentials.idToken) else { return }
        print(credentials.accessToken)
        if !saveToken(credentials.accessToken, for: user) { return }
        completion(user)
    }
    
}
