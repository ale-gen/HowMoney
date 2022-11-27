//
//  LocalNotifiactionProvider.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 27/11/2022.
//

import SwiftUI

class LocalNotificationProvider: ObservableObject {
    
    private enum Constants {
        static let timeInterval: TimeInterval = 10.0
    }
    
    static let shared: LocalNotificationProvider = LocalNotificationProvider()
    
    var notifications: [Notification]
    
    init() {
        notifications = []
    }
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { granted, error in
            guard granted else {
                print("🚫 Permissions are denied. User cannot get notifiactions, because of error: \(error?.localizedDescription ?? .empty)")
                return
            }
            
            print("✅ Permissions are granetd. User can get notifications.")
        }
    }
    
    func sendNotification(title: String, subtitle: String?) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle ?? .empty
        content.sound = .default
        content.badge = (UIApplication.shared.applicationIconBadgeNumber + 1) as NSNumber
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Constants.timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
}
