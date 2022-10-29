//
//  ListViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 28/10/2022.
//

import Foundation


class ListViewModel<Element>: ObservableObject {
    
    @Published var items: [Element] = []
    var didSelectItem: (Asset) -> Void = { _ in }
    
    init(items: [Element]) {
        self.items = items
    }
    
    init(items: [Element], didSelectItem: @escaping (Asset) -> Void) {
        self.items = items
        self.didSelectItem = didSelectItem
    }
    
}
