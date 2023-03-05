//
//  UIButton+.swift
//  STITCH
//
//  Created by neuli on 2023/02/16.
//

import UIKit

extension UIButton {
    func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let color = color else { return }
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))

        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()

        setBackgroundImage(backgroundImage, for: state)
    }
    
    func generateHaptic(_ feedBackType: UINotificationFeedbackGenerator.FeedbackType) {
        let hapticNotification = UINotificationFeedbackGenerator()
        hapticNotification.notificationOccurred(feedBackType)
    }
}
