//
//  NotificationService.swift
//  HowMoney
//
//  Created by Aleksandra Generowicz on 29/11/2022.
//

import Foundation

class NotificationService {
    
    public var onReceive: ((Notification) -> Void)?
    
    private let baseWebsocketUrl: String = ""
    private var webSocketTask: URLSessionWebSocketTask?
    
    init() {
        connect()
    }
    
    func connect() {
        let url = URL(string: "wss://\(baseWebsocketUrl)/ws/socket-server/")!
        let config = URLSessionConfiguration.default
        config.shouldUseExtendedBackgroundIdleMode = true
        let session = URLSession(configuration: config)
        webSocketTask = session.webSocketTask(with: url)
        webSocketTask?.receive(completionHandler: onReceiveHandler)
        webSocketTask?.resume()
    }
    
    @objc func keepConnection() {
        self.connect()
    }
    
    func disconnect() {
        print("🔌 Websockets disconnected!")
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
    }
    
    private func onReceiveHandler(incoming: Result<URLSessionWebSocketTask.Message, Error>) {
        webSocketTask?.receive(completionHandler: onReceiveHandler)
        if case .success(let message) = incoming {
            print(message)
            onMessage(message: message)
        }
        else if case .failure(let error) = incoming {
            print("❌ Error on receive in NotificationService: ", error)
        }
    }
    
    private func onMessage(message: URLSessionWebSocketTask.Message) {
        if case .string(let text) = message {
            guard let data = text.data(using: .utf8),
                  let notificationDto = try? JSONDecoder().decode(NotificationDTO.self, from: data)
            else { return }
            
            let notification = Notification.parse(from: notificationDto)
            onReceive?(notification)
        }
    }
    
    
}
