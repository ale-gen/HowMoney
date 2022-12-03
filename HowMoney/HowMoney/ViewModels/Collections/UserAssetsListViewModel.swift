//
//  UserAssetsListViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 02/12/2022.
//

import Foundation

class UserAssetsListViewModel: ListViewModel<UserAsset> {
    
    @Published var userAssets: Dictionary<Asset, ([UserAsset], Bool)> = [:]
    
    private var userAssetTask: Task<(), Error>?
    
    override init(service: any Service) {
        super.init(service: service)
    }
    
    @MainActor func getUserAssets(_ completion: @escaping () -> Void) {
        userAssetTask = Task {
            getItems { [weak self] in
                completion()
                guard let self = self else { return }
                self.userAssets = Dictionary(grouping: self.items, by: { $0.asset }).mapValues { ($0, false)}
            }
        }
        
    }
}
