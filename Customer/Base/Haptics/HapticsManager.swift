//
//  HapticsManager.swift
//  Customer
//
//  Created by Md Shohidur Rahman on 10/4/23.
//

import Foundation
import UIKit

fileprivate final class HapticsManager {
    
    static let shared = HapticsManager()
    private let feedback = UINotificationFeedbackGenerator()
    
    private init() {}
    
    func trigger(_ notification: UINotificationFeedbackGenerator.FeedbackType){
        feedback.notificationOccurred(notification)
    }
}


func haptic(_ notification: UINotificationFeedbackGenerator.FeedbackType){
    if UserDefaults.standard.bool(forKey: UserDefaultKeys.hapticsEnabled){
        HapticsManager.shared.trigger(notification)
    }
}
