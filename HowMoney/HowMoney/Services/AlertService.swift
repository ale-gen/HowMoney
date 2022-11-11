//
//  AlertService.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 09/11/2022.
//

import Foundation

class AlertService: Service {
    
    typealias ServiceType = Alert
    
    func sendData() {
        /* */
    }
    
    func getData() async throws -> [Alert] {
        /* */
        return Alert.AlertsMock
    }
    
    func updateData(_ model: Alert) -> Alert? {
        /* */
        return Alert.AlertsMock.first
    }
    
    func deleteData() -> Bool {
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
