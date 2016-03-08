//
//  String+Extensions.swift
//  Docker
//
//  Created by baga on 3/1/16.
//  Copyright © 2016 Niteco. All rights reserved.
//

import Foundation

extension String {
    
    
    /**
     Encode a String to Base64
     
     :returns:
     */
    func toBase64()->String{
        
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)
        
        return data!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
    }
    
}