//
//  HapticManager.swift
//  SwiftUICrypto
//
// Created by pratik on 09/12/24.
//

import Foundation
import SwiftUI

class HapticManager {
    private init() {}

    private static let generator = UINotificationFeedbackGenerator()

    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        self.generator.notificationOccurred(type)
    }
}
