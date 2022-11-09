//
//  NetworkError.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 09/11/2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidData
    case unauthorized
    case unknown
}
