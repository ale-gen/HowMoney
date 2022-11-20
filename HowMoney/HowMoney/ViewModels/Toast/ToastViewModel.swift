//
//  ToastViewModel.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 20/11/2022.
//

import SwiftUI

class ToastViewModel: ObservableObject {
    
    static let shared: ToastViewModel = ToastViewModel()
    
    @Published var isShowing: Bool = false
    private(set) var toast: ToastModel
    
    init(toast: ToastModel? = nil) {
        self.toast = toast ?? ToastModel(message: .empty, type: .success)
    }
    
    func update(message: String, type: ToastType) {
        updateMessage(message)
        updateType(type)
    }
    
    func updateMessage(_ message: String) {
        toast.message = message
    }
    
    func updateType(_ type: ToastType) {
        toast.type = type
    }
    
    func show() {
        DispatchQueue.main.async { [weak self] in
            withAnimation(.spring()) {
                self?.isShowing = true
            }
        }
    }
    
    func hide() {
        DispatchQueue.main.async { [weak self] in
            withAnimation(.spring()) {
                self?.isShowing = false
            }
        }
    }
}
