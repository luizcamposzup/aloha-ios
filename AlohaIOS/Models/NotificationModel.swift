//
//  Notification.swift
//  AlohaIOS
//
//  Created by zupper on 01/01/20.
//  Copyright © 2020 Luizhcarminati. All rights reserved.
//

import Foundation

struct NotificationRequest: Codable {
    var name: String
    var email: String
}

struct NotificationResponse: Codable {
    var success: [String]
    var fail: [String]
}
