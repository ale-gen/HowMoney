//
//  Service.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 23/10/2022.
//

import Foundation


protocol Service {
    
    associatedtype ServiceType
    
    func sendData(_ completion: @escaping () -> Void)
    func getData(_ completion: @escaping () -> Void) -> [ServiceType]
    func updateData(_ model: ServiceType, _ completion: @escaping () -> Void) -> ServiceType
    func deleteData(_ completion: @escaping () -> Void) -> Bool
    
    func login(_ completion: @escaping (AuthUser) -> Void)
    func logout(_ completion: @escaping () -> Void)
    
}
