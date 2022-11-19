//
//  ToastModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 19/11/2022.
//

import SwiftUI

enum ToastType {
    case error
    case success
    
    var color: Color {
        switch self {
        case .error:
            return .red
        case .success:
            return .green
        }
    }
    
    var title: String {
        switch self {
        case .error:
            return Localizable.toastViewErrorTitle.value
        case .success:
            return Localizable.toastViewSuccessTitle.value
        }
    }
    
    var icon: Image {
        switch self {
        case .error:
            return Icons.circleClose.value
        case .success:
            return Icons.circleSuccess.value
        }
    }
}

struct ToastModel {
    let message: String
    let type: ToastType
}
