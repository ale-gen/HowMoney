//
//  ListViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 28/10/2022.
//

import Foundation


class ListViewModel<Element>: ObservableObject {
    
    @Published var items: [Element] = []
    
    var didSelectItem: (Element) -> Void = { _ in }
    
    private var service: any Service
    private var task: Task<(), Never>?
    
    init(service: any Service) {
        self.service = service
    }
    
    init(service: any Service,
         didSelectItem: @escaping (Element) -> Void) {
        self.service = service
        self.didSelectItem = didSelectItem
    }
    
    func getItems(_ completion: @escaping () -> Void) {
        task = Task {
            do {
                items = try await service.getData() as? [Element] ?? []
                completion()
            } catch let error {
                print("Error during assets fetching: \(error.localizedDescription)")
                completion()
            }
        }
    }
    
}
