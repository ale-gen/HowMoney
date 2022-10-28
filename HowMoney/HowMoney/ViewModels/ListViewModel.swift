//
//  ListViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 28/10/2022.
//

import Foundation


class ListViewModel<Element>: ObservableObject {
    
    @Published var items: [Element] = []
    
    init(items: [Element]) {
        self.items = items
    }
    
}
