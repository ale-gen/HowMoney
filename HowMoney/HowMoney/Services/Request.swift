//
//  Request.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 09/11/2022.
//

import Foundation

enum RequestType: String {
    case get
    case post
    case patch
    case put
    case delete
    
    var value: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .patch:
            return "PATCH"
        case .put:
            return "PUT"
        case .delete:
            return "DELETE"
        }
    }
}

protocol RequestBody { }

struct MultipleRecordsRequestBody: RequestBody {
    var body: [[String: Any]]
}

struct SingleRecordRequestBody: RequestBody {
    var body: [String: Any]
}

enum RequestValues {
    case userAsset(assetName: String, value: Float, type: String)
    case userPreferences(preferenceCurrency: String, weeklyReports: Bool, alertsOnEmail: Bool)
    case alert
    
    var body: RequestBody {
        switch self {
        case let .userAsset(assetName, value, type):
            return MultipleRecordsRequestBody(body: [["assetName": assetName,
                                                      "value": Double(value),
                                                      "type": type]] as [[String: Any]])
        case let .userPreferences(preferenceCurrency, weeklyReports, alertsOnEmail):
            return SingleRecordRequestBody(body: ["preferenceCurrency": preferenceCurrency,
                                                  "weeklyReports": weeklyReports,
                                                  "alertsOnEmail": alertsOnEmail] as [String: Any])
        case .alert:
            return SingleRecordRequestBody(body: [:] as [String: Any])
        }
    }
}

protocol RequestProtocol {
    func createRequest(url: URL, token: Data?, method: RequestType, body: RequestBody?) -> URLRequest
}

extension RequestProtocol {
    
    func createRequest(url: URL, token: Data? = nil, method: RequestType, body: RequestBody? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.value
        if let definedBody = body {
            let singleExtractedBody = extractSingleRecordBody(definedBody)
            let multipleExtractedBody = extractMultipleRecordsBody(definedBody)
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            let bodyData = try? JSONSerialization.data(
                withJSONObject: singleExtractedBody ?? multipleExtractedBody ?? [String]() as Any,
                options: []
            )
            request.httpBody = bodyData
        }
        if let safeToken = token, let stringToken = String(data: safeToken, encoding: .utf8) {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("Bearer \(stringToken)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
    
    private func extractSingleRecordBody(_ body: RequestBody?) -> [String: Any]? {
        guard let body = body,
              let extractedBody = body as? SingleRecordRequestBody
        else { return nil }
        
        return extractedBody.body
    }
    
    private func extractMultipleRecordsBody(_ body: RequestBody?) -> [[String: Any]]? {
        guard let body = body,
              let extractedBody = body as? MultipleRecordsRequestBody
        else { return nil }
        
        return extractedBody.body
    }
}
