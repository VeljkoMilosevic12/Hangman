//
//  NotificationService.swift
//  Hangman
//
//  Created by Veljko Milosevic on 24/04/2021.
//  Copyright © 2021 Veljko Milosevic. All rights reserved.
//

import Foundation
import NotificationCenter

//class NotificationServices {
//    
//    private let center = UNUserNotificationCenter.current()
//    
//    func askForPermission() {
//        if AppSettings.shared.isFirstLaunch == false {
//            center.requestAuthorization(options: [.alert, .sound]) {
//                granted, error in
//                if granted {
//                    AppSettings.shared.notificationsOn = true
//                    print("We have permission")
//                    AppSettings.shared.isFirstLaunch = true
//                    self.setupNotification()
//                } else {
//                   // AppSettings.shared.notificationsOn = false
//                   // AppSettings.shared.isFirstLaunch = true
//                    print("Permission denied")
//                }
//            }
//        }
//        return
//    }
//    
//    private func setupNotification() {
//        if AppSettings.shared.notificationsOn {
//            let content = UNMutableNotificationContent()
//            content.title = "Hello!"
//            content.body = "Play me today !!"
//            content.sound = UNNotificationSound.default
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60,repeats: true)
//            let request = UNNotificationRequest(identifier: "MyNotification",content: content,trigger: trigger)
//            
//            center.add(request)
//            print("setovano je")
//        }
//            
//        else {
//            print("nije setovano")
//            return}
//            
//        
//    }
//}
