//
//  AssetService.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 09/11/2022.
//

import Foundation

class AssetService: Service {
    
    typealias ServiceType = Asset
    
    func sendData(_ completion: @escaping () -> Void) {
        /* */
    }
    
    func getData(_ completion: @escaping () -> Void) -> [Asset] {
        print("Getting data in asset service")
        completion()
        return Asset.AssetsMock
    }
    
    func updateData(_ model: Asset, _ completion: @escaping () -> Void) -> Asset {
        /* */
        return Asset.AssetsMock.first!
    }
    
    func deleteData(_ completion: @escaping () -> Void) -> Bool {
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
