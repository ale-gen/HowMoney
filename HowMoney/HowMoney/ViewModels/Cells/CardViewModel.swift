//
//  CardViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 19/11/2022.
//

import SwiftUI

class CardViewModel: ObservableObject {
    
    var id: String {
        return UUID().uuidString
    }
    
    private(set) var title: String
    private(set) var mainValue: Float
    private(set) var currency: PreferenceCurrency
    private(set) var subtitle: String?
    private(set) var subValue: Float?
    private(set) var additionalValue: Int?
    private(set) var isIncreased: Bool?
    private(set) var gradientColors: [Color]
    
    init(title: String,
         mainValue: Float,
         currency: PreferenceCurrency,
         subtitle: String? = nil,
         subValue: Float? = nil,
         additionalValue: Int? = nil,
         isIncreased: Bool?,
         gradientColor: [Color] = [.lightBlue, .lightGreen]) {
        self.title = title
        self.mainValue = mainValue
        self.currency = currency
        self.subtitle = subtitle
        self.subValue = subValue
        self.additionalValue = additionalValue
        self.isIncreased = isIncreased
        self.gradientColors = gradientColor
    }
    
}

extension CardViewModel: Identifiable, Hashable {
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    static func == (lhs: CardViewModel, rhs: CardViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}
