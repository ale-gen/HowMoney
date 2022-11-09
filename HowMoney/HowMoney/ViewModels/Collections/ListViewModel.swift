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
    
    private var service: (any Service)?
    
    init(service: (any Service)? = nil) {
        self.service = service
    }
    
    init(service: (any Service)? = nil,
         didSelectItem: @escaping (Asset) -> Void) {
        self.service = service
        self.didSelectItem = didSelectItem
    }
    
    func getItems() {
        let fetchedItems = service?.getData {
            print("Data was fetched!")
        }
        guard let fetchedItems = fetchedItems as? [Element] else { return }
        self.items = fetchedItems
    }
    
}
