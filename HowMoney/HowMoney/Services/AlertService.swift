//
//  AlertService.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 09/11/2022.
//

import Foundation

class AlertService: Service {
    
    typealias ServiceType = Alert
    
    func sendData(requestValues: RequestValues) async throws -> Alert? {
        /* */
        return nil
    }
    
    func getData(_ parameters: Any...) async throws -> [Alert] {
        /* */
        return Alert.AlertsMock
    }
    
    func updateData(_ model: Alert) async throws -> Alert? {
        /* */
        return Alert.AlertsMock.first
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
