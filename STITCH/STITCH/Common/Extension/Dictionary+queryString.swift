//
//  Dictionary+queryString.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import Foundation

extension Dictionary {
    var queryString: String {
        return self.map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
}
