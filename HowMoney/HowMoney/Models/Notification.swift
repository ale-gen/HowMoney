//
//  Notification.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 29/11/2022.
//

import Foundation

struct Notification {
    let type: String
    let alerts: [NotificationContent]
    
    static func parse(from modelDto: NotificationDTO) -> Notification {
        return Notification(type: modelDto.type, alerts: modelDto.message.map { NotificationContent(receiver: $0.email, title: "⚠️ Alert", subtitle: $0.alert_msg) })
    }
}

struct NotificationContent {
    let receiver: String
    let title: String
    let subtitle: String
}
