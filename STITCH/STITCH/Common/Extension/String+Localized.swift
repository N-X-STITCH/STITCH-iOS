//
//  String+Localized.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import Foundation

extension String {
    // label.text = "Signup".localized
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "")
    }
}
