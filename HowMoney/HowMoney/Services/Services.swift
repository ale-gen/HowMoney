//
//  Service.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 23/10/2022.
//

import Foundation

struct Services {
    static let authService: AuthorizationService = AuthorizationService()
    static let assetService: AssetService = AssetService()
}


protocol Service: RequestProtocol {
    
    associatedtype ServiceType
    
    func sendData()
    func getData() async throws -> [ServiceType]
    func updateData(_ model: ServiceType) -> ServiceType
    func deleteData() -> Bool
    
    func login(_ completion: @escaping (AuthUser) -> Void)
    func logout(_ completion: @escaping () -> Void)
    
}
