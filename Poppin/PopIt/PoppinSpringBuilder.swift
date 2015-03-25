//
//  PoppinBasicBuilder.swift
//  Poppin
//
//  Created by Kelton Person on 3/16/15.
//  Copyright (c) 2015 Poppin. All rights reserved.
//

import Foundation

class PoppinSpringBuilder {
    
    private let propertyName: String
    private var toVal: AnyObject?
    private var startVelocity: CGFloat?
    private var springSpeed: CGFloat?
    private var springBounciness: CGFloat?
    private var dynamicTension: CGFloat?
    private var dynamicFriction: CGFloat?
    private var dynamicMass: CGFloat?

    
    init(propertyName: String) {
        self.propertyName = propertyName
    }
    
    func to(toVal: AnyObject) -> PoppinSpringBuilder {
        self.toVal = toVal
        return self
    }
    
    func to(toVal: CGPoint) -> PoppinSpringBuilder {
        self.toVal = NSValue(CGPoint:toVal)
        return self
    }
    
    func to(toVal: CGRect) -> PoppinSpringBuilder {
        self.toVal = NSValue(CGRect:toVal)
        return self
    }
    
    func velocity(startVelocity: CGFloat) -> PoppinSpringBuilder {
        self.startVelocity = startVelocity
        return self
    }
    
    func speed(springSpeed: CGFloat) -> PoppinSpringBuilder {
        self.springSpeed = springSpeed
        return self
    }
    
    func bounciness(springBounciness: CGFloat) -> PoppinSpringBuilder {
        self.springBounciness = springBounciness
        return self
    }
    
    func friction(dynamicFriction: CGFloat) -> PoppinSpringBuilder {
        self.dynamicFriction = dynamicFriction
        return self
    }
    
    func tension(dynamicTension: CGFloat) -> PoppinSpringBuilder {
        self.dynamicTension = dynamicTension
        return self
    }
    
    func mass(dynamicMass: CGFloat) -> PoppinSpringBuilder {
        self.dynamicMass = dynamicMass
        return self
    }
    
    
    
    func build() -> POPSpringAnimation {
        let anim = POPSpringAnimation(propertyNamed: propertyName)
        if let toV: AnyObject = toVal {
            anim.toValue = toVal
        }
        if let v = self.startVelocity {
            anim.velocity = v
        }
        if let s = self.springSpeed {
            anim.springSpeed = s
        }
        if let b = self.springBounciness {
            anim.springBounciness = b
        }
        if let f = self.dynamicFriction {
            anim.dynamicsFriction = f
        }
        if let t = self.dynamicTension {
            anim.dynamicsTension = t
        }
        if let m = self.dynamicMass {
            anim.dynamicsMass = m
        }
        return anim
    }
    
    
}