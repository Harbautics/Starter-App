//
//  chatt.swift
//  Chatter
//
//  Created by Troy Stacer on 9/23/18.
//  Copyright © 2018 Haurbautics. All rights reserved.
//

import Foundation
import UIKit
class Chatt {
    var username: String
    var message: String
    var timestamp: String
    init(username: String, message: String, timestamp: String) {
        self.username = username
        self.message = message
        self.timestamp = timestamp
    } }
