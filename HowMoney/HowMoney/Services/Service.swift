//
//  Service.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 23/10/2022.
//

import Foundation


protocol Service {
    
    func sendData(_ completion: @escaping () -> Void)
    func getData(_ completion: @escaping () -> Void) -> [Model]
    func updateData(_ model: Model, _ completion: @escaping () -> Void) -> Model
    func deleteData(_ completion: @escaping () -> Void) -> Bool
    
    func login(_ completion: @escaping () -> Void)
    func logout(_ completion: @escaping () -> Void)
    
}
