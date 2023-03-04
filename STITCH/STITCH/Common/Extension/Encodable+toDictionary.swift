//
//  Encodable+toDictionary.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import Foundation

extension Encodable {
    var toDictionary: [String: Any]? {
        guard let object = try? JSONEncoder().encode(self) else { return nil }
        guard let dictionary = try? JSONSerialization.jsonObject(
            with: object, options: []
        ) as? [String:Any] else { return nil }
        return dictionary
    }
}
