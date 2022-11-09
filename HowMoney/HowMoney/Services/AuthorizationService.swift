//
//  AuthorizationService.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 22/10/2022.
//

import Foundation
import Auth0

struct AuthorizationService: Service {
    
    func login(_ completion: @escaping (AuthUser) -> Void) {
        Auth0
            .webAuth()
            .parameters(["prompt": "login"])
            .start { result in
                switch result {
                case let .success(credentials):
                    Keychain.save(data: credentials.idToken)
                    guard let user = AuthUser(from: credentials.idToken) else { return }
                    completion(user)
                case let .failure(error):
                    print(error)
                }
            }
    }
    
    func logout(_ completion: @escaping () -> Void) {
        Keychain.delete()
        completion()
    }
    
    func sendData() { /**/ }
    func getData() -> [Model] { return [] }
    func updateData(_ model: Model) -> Model { return Model() }
    func deleteData() -> Bool { return true }
    
}
