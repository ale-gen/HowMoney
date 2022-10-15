//
//  Extension+String.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 14/10/2022.
//

import Foundation

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func date() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.date(from: self)
    }
    
}
