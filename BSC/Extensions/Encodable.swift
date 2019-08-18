//
//  Encodable.swift
//  BSC
//
//  Created by Andrey Mosin on 17/08/2019.
//  Copyright © 2019 Andrey Mosin. All rights reserved.
//

import Foundation

extension Encodable {
    func asDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self), let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return [:]
        }
        return dictionary
    }
}
