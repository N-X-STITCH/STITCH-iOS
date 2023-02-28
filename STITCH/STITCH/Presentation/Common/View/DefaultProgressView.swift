//
//  DefaultProgressView.swift
//  STITCH
//
//  Created by neuli on 2023/02/24.
//

import UIKit

final class DefaultProgressView: UIProgressView {
    
    enum Current {
        case nickname, profile, location, sports, complete
        
        var start: Float {
            switch self {
            case .nickname: return 0.0
            case .profile: return 0.2
            case .location: return 0.4
            case .sports: return 0.6
            case .complete: return 0.8
            }
        }
        
        var end: Float {
            switch self {
            case .nickname: return 0.2
            case .profile: return 0.4
            case .location: return 0.6
            case .sports: return 0.8
            case .complete: return 1.0
            }
        }
    }
    
    // MARK: - Properties
    
    var curView: Current!
    var cur: Float = 0.0
    var timer: Timer?
    
    // MARK: - Initializer
    
    init(_ curView: Current) {
        super.init(frame: .zero)
        progressViewStyle = .default
        progressTintColor = .yellow05_primary
        trackTintColor = .gray12
        self.progress = curView.start
        self.curView = curView
        self.cur = curView.start
        setTimer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            timeInterval: 0.01,
            target: self,
            selector: #selector(animation),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc func animation() {
        cur += 0.01
        setProgress(cur, animated: true)
        if curView.end <= cur {
            timer?.invalidate()
            timer = nil
        }
    }
}
