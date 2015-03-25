//
//  PoppinBasicBuilder.swift
//  Poppin
//
//  Created by Kelton Person on 3/16/15.
//  Copyright (c) 2015 Poppin. All rights reserved.
//

import Foundation

class PoppinBasicBuilder {
    
    private let propertyName: String
    private var toVal: AnyObject?
    private var timeInterval: NSTimeInterval?

    
    init(propertyName: String) {
        self.propertyName = propertyName
    }
    
    func to(toVal: AnyObject) -> PoppinBasicBuilder {
        self.toVal = toVal
        return self
    }
    
    func to(toVal: CGPoint) -> PoppinBasicBuilder {
        self.toVal = NSValue(CGPoint:toVal)
        return self
    }
    
    func to(toVal: CGRect) -> PoppinBasicBuilder {
        self.toVal = NSValue(CGRect:toVal)
        return self
    }
    
    func time(interval: NSTimeInterval) -> PoppinBasicBuilder {
        self.timeInterval = interval
        return self
    }
    
    func build() -> POPBasicAnimation {
        let anim = POPBasicAnimation(propertyNamed: propertyName)
        if let toV: AnyObject = toVal {
            anim.toValue = toVal
        }
        if let tI = self.timeInterval {
            anim.duration = tI
        }
        return anim
    }
    
    
}