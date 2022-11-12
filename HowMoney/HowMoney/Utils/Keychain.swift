//
//  Keychain.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 23/10/2022.
//

import Foundation

enum KeychainError: Error {
    case badData
    case duplicateItem
    case itemNotFound
    case unknown(OSStatus)
}

class Keychain {
    
    static func save(account: String, service: String, token: String) throws {
        
        guard let tokenData = token.data(using: .utf8) else {
            throw KeychainError.badData
        }
        
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account as AnyObject,
            kSecAttrService as String: service as AnyObject,
            kSecValueData as String: tokenData as AnyObject
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else {
            throw KeychainError.duplicateItem
        }
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }
        print("Token saved! ✅")
    }
    
    static func get(account: String, service: String) throws -> Data {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account as AnyObject,
            kSecAttrService as String: service as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }
        
        return result as! Data
    }
    
    static func logout()  {
        let secItemClasses =  [
            kSecClassGenericPassword,
            kSecClassInternetPassword,
            kSecClassCertificate,
            kSecClassKey,
            kSecClassIdentity,
        ]
        for itemClass in secItemClasses {
            let spec: NSDictionary = [kSecClass: itemClass]
            SecItemDelete(spec)
        }
    }
}
