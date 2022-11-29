//
//  NotificationDTO.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 29/11/2022.
//

import Foundation

struct NotificationDTO: Decodable {
    let type: String
    let message: [NotificationContentDTO]
}

struct NotificationContentDTO: Decodable {
    let email: String
    let alert_msg: String
}
