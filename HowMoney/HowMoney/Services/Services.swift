//
//  Service.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 23/10/2022.
//

import SwiftUI

struct Services {
    
    static let authService: AuthorizationService = AuthorizationService()
    static let assetService: AssetService = AssetService()
    static let assetHistoryService: AssetHistoryService = AssetHistoryService()
    static let alertService: AlertService = AlertService()
    static let userAssetService: UserAssetService = UserAssetService()
    static let transactionService: TransactionService = TransactionService()
    static let walletService: WalletService = WalletService()
    static let notificationService: NotificationService = NotificationService()
}


protocol Service: RequestProtocol {
    
    associatedtype ServiceType
    
    func sendData(requestValues: RequestValues) async throws -> ServiceType?
    func getData(_ parameters: Any...) async throws -> [ServiceType]
    func updateData(_ model: ServiceType) async throws -> ServiceType?
    func deleteData(_ parameters: Any...) async throws -> Bool
    
    func login(_ completion: @escaping (AuthUser) -> Void)
    func logout(_ completion: @escaping () -> Void)
    func resetPassword() async throws -> Bool
    
}
