//
//  String+Date.swift
//  STITCH
//
//  Created by neuli on 2023/03/19.
//

import Foundation

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.date(from: self) ?? Date()
    }
}
