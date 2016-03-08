//
//  CloudDateParser.swift
//  Docker
//
//  Created by baga on 3/1/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

import Foundation

struct CloudDateParser {
    //Tue, 1 Mar 2016 03:52:18 +0000
    static let dateFormat     = "EEE, d MMM yyyy hh:mm:ss Z"
    private let dateFormatter = NSDateFormatter()
    
    init() {
        dateFormatter.dateFormat = CloudDateParser.dateFormat
        
    }
    
    func dateFromString(str: String) -> NSDate?{
        return dateFormatter.dateFromString(str)
    }
    
    func stringFromDate(date: NSDate) -> String{
        return dateFormatter.stringFromDate(date)
    }
}