//
//  ProfileTabBarItem.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 21/10/2022.
//

import SwiftUI

struct ProfileTabBarItem: View {
    
    var didLogoutButtonTapped: (() -> Void)?
    
    var body: some View {
        VStack {
            Spacer()
            RectangleButton(title: Localizable.authorizationSignOutButtonTitle.value, didButtonTapped: didLogoutButtonTapped)
        }
    }
}

struct ProfileTabBarItem_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTabBarItem()
    }
}
