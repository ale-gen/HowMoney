//
//  TabBarItemsPreferenceKey.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 08/10/2022.
//

import SwiftUI

struct TabBarItemsPreferenceKey: PreferenceKey {
    
    static var defaultValue: [TabBarItem] = []
    
    static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
        value += nextValue()
    }
    
}
