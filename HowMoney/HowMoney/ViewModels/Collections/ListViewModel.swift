//
//  ListViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 28/10/2022.
//

import SwiftUI

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
                print("Error during elements fetching: \(error.localizedDescription)")
                completion()
            }
        }
    }
    
    func deleteAlert(_ element: Alert, _ completion: @escaping () -> Void) {
        deleteItem(String(element.id), completion, successCompletion: { [weak self] in
            DispatchQueue.main.async {
                withAnimation {
                    self?.items.removeAll(where: { ($0 as? Alert)?.id == element.id})
                }
            }
        })
    }
    
    func deleteItem(_ itemId: String, _ completion: @escaping () -> Void, successCompletion: @escaping () -> Void) {
        task = Task {
            do {
                let result = try await service.deleteData(itemId)
                if result {
                    successCompletion()
                    ToastViewModel.shared.update(message: Localizable.userAssetsDeletionSuccesssToastMessageText.value, type: .success)
                    completion()
                }
            } catch let error {
                print("Error during element deletion: \(error.localizedDescription)")
                ToastViewModel.shared.update(message: Localizable.userAssetsDeletionFailureToastMessageText.value, type: .error)
                completion()
            }
        }
    }
    
}
