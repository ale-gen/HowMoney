//
//  Extension+Date.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 16/11/2022.
//

import Foundation

extension Date {
    
    var yeasterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    
    var today: Date {
        return Calendar.current.date(byAdding: .day, value: 0, to: self)!
    }
    
    var previousWeek: Date {
        return Calendar.current.date(byAdding: .day, value: -7, to: self)!
    }
    
    var previousMonth: Date {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)!
    }
    
    var previousHalfYear: Date {
        return Calendar.current.date(byAdding: .month, value: -6, to: self)!
    }
    
    var previousYear: Date {
        return Calendar.current.date(byAdding: .year, value: -1, to: self)!
    }
    
    func text() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd'Z'"
        return dateFormat.string(from: self)
    }
}
