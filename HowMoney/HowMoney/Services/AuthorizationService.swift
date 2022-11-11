//
//  AuthorizationService.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 22/10/2022.
//

import SwiftUI
import Auth0

struct AuthorizationService: Service {
    
    @EnvironmentObject var userState: UserStateViewModel
    
    func login(_ completion: @escaping (AuthUser) -> Void) {
        Auth0
            .webAuth()
            .parameters(["prompt": "login"])
            .audience(extractAudienceValue() ?? .empty)
            .start { result in
                switch result {
                case let .success(credentials):
                    guard let user = AuthUser(from: credentials.idToken) else { return }
                    if !saveToken(credentials.accessToken, for: user) { return }
                    completion(user)
                case let .failure(error):
                    print(error)
                }
            }
    }
    
    func logout(_ completion: @escaping () -> Void) {
        Keychain.logout()
        completion()
    }
    
    func sendData() { /**/ }
    func getData() -> [Model] { return [] }
    func updateData(_ model: Model) -> Model? { return nil }
    func deleteData() -> Bool { return false }
    
    private func extractAudienceValue() -> String? {
        guard let path = Bundle.main.path(forResource: "Auth0", ofType: "plist"),
              let values = NSDictionary(contentsOfFile: path) as? [String: Any],
              let audience = values["Audience"] as? String
        else { return nil }
        
        return audience
    }
    
    private func saveToken(_ accessToken: String, for user: AuthUser) -> Bool {
        do {
            try Keychain.save(account: user.email, service: "HowMoney", token: accessToken)
            return true
        } catch {
            print("Token wasn't saved ⚠️")
            return false
        }
    }
    
}
