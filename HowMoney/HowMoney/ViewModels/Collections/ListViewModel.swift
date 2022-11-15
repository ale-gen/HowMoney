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
    
    @MainActor func getItems(_ completion: @escaping () -> Void, _ parameters: Any...) {
        task = Task {
            do {
                self.items = try await service.getData(parameters) as! [Element]
                completion()
            } catch let error {
                print("Error during assets fetching: \(error.localizedDescription)")
                completion()
            }
        }
    }
    
    @MainActor func deleteItem(_ userAsset: UserAsset, _ failureCompletion: @escaping () -> Void) {
        task = Task {
            do {
                let result = try await service.deleteData(userAsset.asset.name)
                if result {
                    items.removeAll(where: { ($0 as? UserAsset)?.id == userAsset.id})
                }
            } catch let error {
                print("Error during assets fetching: \(error.localizedDescription)")
                failureCompletion()
            }
        }
    }
    
}
