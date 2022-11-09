//
//  Request.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 09/11/2022.
//

import Foundation

protocol RequestProtocol {
    func createRequest(url: URL, token: Data?, method: String?, body: [String: Any]?) -> URLRequest
    func createPatchRequest(url: URL, token: Data, patchBody: [[String: String]]) -> URLRequest
}

extension RequestProtocol {
    
    func createRequest(url: URL, token: Data? = nil, method: String?, body: [String: Any]? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        if let definedBody = body {
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            let bodyData = try? JSONSerialization.data(
                withJSONObject: definedBody,
                options: []
            )
            request.httpBody = bodyData
        }
        if let safeToken = token, let stringToken = String(data: safeToken, encoding: .utf8) {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue( "Bearer \(stringToken)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
    
    func createPatchRequest(url: URL, token: Data, patchBody: [[String: String]]) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let bodyData = try? JSONSerialization.data(
            withJSONObject: patchBody,
            options: []
        )
        if let stringToken = String(data: token, encoding: .utf8) {
            request.httpBody = bodyData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue( "Bearer \(stringToken)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
}
