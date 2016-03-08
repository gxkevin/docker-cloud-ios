//
//  JSONParserType.swift
//  Docker
//
//  Created by baga on 3/7/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: AnyObject]

protocol JSONParserType {
    typealias T
    static func parseJSON(json: JSONDictionary) -> T?
}