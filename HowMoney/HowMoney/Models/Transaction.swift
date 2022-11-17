//
//  Transaction.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 16/11/2022.
//

import Foundation

enum TransactionDateRange: CaseIterable {
    case day
    case week
    case month
    case halfYear
    case year
    
    var shortName: String {
        switch self {
        case .day:
            return "D"
        case .week:
            return "W"
        case .month:
            return "M"
        case .halfYear:
            return "6M"
        case .year:
            return "Y"
        }
    }
    
    var date: Date {
        switch self {
        case .day:
            return Date().today
        case .week:
            return Date().previousWeek
        case .month:
            return Date().previousMonth
        case .halfYear:
            return Date().previousHalfYear
        case .year:
            return Date().previousYear
        }
    }
}

struct Transaction: Hashable {
    let assetName: String
    let value: Float
    let date: Date
    
    static func parse(from model: TransactionDTO) -> Transaction {
        return Transaction(assetName: model.assetIdentifier, value: model.value, date: model.timeStamp)
    }
    
    private static let DatesMock: [Date] = [
        "26/09/2022", "27/09/2022", "28/09/2022", "29/09/2022", "30/09/2022", "01/10/2022", "02/10/2022", "03/10/2022", "04/10/2022", "05/10/2022", "06/10/2022", "07/10/2022", "08/10/2022", "09/10/2022", "10/10/2022", "11/10/2022", "12/10/2022", "13/10/2022", "14/10/2022", "15/10/2022"
    ].compactMap { $0.date() }
    
    private static let TransactionsDetailsMock: [(String, Float)] = [
        ("USD", 2300.0),
        ("USD", -5.0),
        ("EUR", 219.23),
        ("BTC", 20.0),
        ("BTC", -20.0),
        ("ZL333", 34.5),
        ("EUR", -3.45),
        ("PLN", 2300),
        ("USD", 2200.1),
        ("EUR", 229.89),
        ("PLN", 456.78)
    ]
    
    static let TransactionsMock: [Transaction] = zip(TransactionsDetailsMock, DatesMock).map { (details, date) in
        let (assetName, value) = details
        return Transaction(assetName: assetName, value: value, date: date)
    }
}
