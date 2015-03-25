//
//  PoppinRegister.swift
//  Poppin
//
//  Created by Kelton Person on 3/16/15.
//  Copyright (c) 2015 Poppin. All rights reserved.
//

import Foundation

var poppinRegisterHash: [String : PoppinAnimation] = [:]

class PoppinRegister {
    
    class func registerAnimation(anim: PoppinAnimation) -> String {
        let key = randomStringWithLength(7)
        poppinRegisterHash[key] = anim
        return key
    }
    
    class func removeAnimation(key: String)  {
        poppinRegisterHash.removeValueForKey(key)
    }
    
    class func randomStringWithLength (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        var randomString : NSMutableString = NSMutableString(capacity: len)
        
        for (var i=0; i < len; i++){
            var length = UInt32 (letters.length)
            var rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString
    }
    
}