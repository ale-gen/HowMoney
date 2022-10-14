//
//  Localizable.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 14/10/2022.
//

import Foundation

protocol Translation {
    var value: String { get }
}

extension Translation where Self: RawRepresentable, Self.RawValue == String {
    
    var value: String {
        return rawValue.localized()
    }
}

enum Localizable: String, Translation {
    
    case welcomeSwipeToGetStarted = "welcome.swipe.to.get.started.title"
    
}
