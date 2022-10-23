//
//  AuthorizationService.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 22/10/2022.
//

import Foundation
import Auth0

struct AuthorizationService: Service {
    
    func login(_ completion: @escaping () -> Void) {
        Auth0
            .webAuth()
            .parameters(["prompt": "login"])
            .start { result in
                switch result {
                case let .success(credentials):
                    print("During login success...")
                    print("Credentials: \(credentials)")
                    let user = User(from: credentials.idToken)
                    completion()
                case let .failure(error):
                    print("During login failure...")
                    print(error)
                }
            }
    }
    
    func logout(_ completion: @escaping () -> Void) {
        completion()
        // Clear cookies
    }
    
    func sendData(_ completion: @escaping () -> Void) { /**/ }
    func getData(_ completion: @escaping () -> Void) -> [Model] { return [] }
    func updateData(_ model: Model, _ completion: @escaping () -> Void) -> Model { return Model() }
    func deleteData(_ completion: @escaping () -> Void) -> Bool { return true }
    
}
