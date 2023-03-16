//
//  String+.swift
//  STITCH
//
//  Created by neuli on 2023/03/17.
//

import Foundation

extension String {
    func feeString() -> String {
        let numberString = self.components(separatedBy: ",").joined()
        guard let number = Int(numberString) else { return numberString }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: number)) ?? ""
    }
    
    func feeInt() -> Int {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let number = numberFormatter.number(from: self)?.intValue else { return 0 }
        return number
    }
}
