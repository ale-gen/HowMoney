//
//  CreationContext.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 30/10/2022.
//

import SwiftUI

enum CreationContext {
    case asset
    case alert
    
    var image: Image {
        switch self {
        case .asset:
            return Icons.dollarSign.value
        case .alert:
            return Icons.bell.value
        }
    }
    
    var destinationView: some View {
        switch self {
        case .asset:
            return AnyView(UserAssetCreationView())
        case .alert:
            return AnyView(EmptyView())
        }
    }
}
