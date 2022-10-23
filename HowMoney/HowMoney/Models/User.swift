//
//  User.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 21/10/2022.
//

import Foundation
import JWTDecode

struct User {
    let id: String
    let name: String
    let email: String
    let emailVerified: String
    let picture: String
    let updatedAt: String
    
    init?(from token: String) {
        guard let jwt = try? decode(jwt: token),
              let id = jwt.subject,
              let name = jwt["name"].string,
              let email = jwt["email"].string,
              let emailVerified = jwt["email_verified"].boolean,
              let picture = jwt["picture"].string,
              let updatedAt = jwt["updated_at"].string
        else {
            return nil
        }
        self.id = id
        self.name = name
        self.email = email
        self.emailVerified = String(describing: emailVerified)
        self.picture = picture
        self.updatedAt = updatedAt
    }
}
