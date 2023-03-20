//
//  Int+.swift
//  STITCH
//
//  Created by neuli on 2023/03/16.
//

import Foundation

extension Int {
    func matchTimeString() -> String {
        let hour = self / 60
        let min = self % 60
        if hour == 0 && min == 0 {
            return "0분"
        } else if hour == 0 {
            return "\(min)분"
        } else {
            return min == 0 ? "\(hour)시간" : "\(hour)시간 \(min)분"
        }
    }
}
