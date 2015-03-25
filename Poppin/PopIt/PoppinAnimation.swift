//
//  PoppinAnimation.swift
//  Poppin
//
//  Created by Kelton Person on 3/13/15.
//  Copyright (c) 2015 Poppin. All rights reserved.
//

import Foundation

protocol PoppinAnimationProtocol {
    
    func delayAnimation(interval: NSTimeInterval) -> PoppinAnimationProtocol
    func addEdge(animation: PoppinAnimationProtocol)
    func addEdge(animation: PoppinAnimationProtocol, _ trigger: () -> Bool)
    func start()
    func registerForApply(handler: () -> Void)
    func registerForCompletion(handler: () -> Void)
    var isComplete:Bool { get }
}

class PoppinAnimation : NSObject, PoppinAnimationProtocol, POPAnimationDelegate {

    private let lifeCycleManager = PoppinLifeCylceManager()
    private let popAnimation: POPAnimation
    private let object: NSObject
    private let key: String
    private var registerKey: String?
    private var hasCompleted = false
    
    
    init(animation: POPAnimation, object: NSObject, key: String) {
        self.popAnimation = animation
        self.object = object
        self.key = key
        super.init()
    }
    
    // MARK: PoppinAnimationProtocol
    
    /**
    :param: interval An interval to wait before executing the animation
    
    :returns: a Poppin animation (self)
    */
    func delayAnimation(interval: NSTimeInterval) -> PoppinAnimationProtocol {
        return lifeCycleManager.delayAnimation(interval, anim: self)
    }
    
    func addEdge(animation: PoppinAnimationProtocol) {
        lifeCycleManager.addChild(animation)
    }
    
    func addEdge(animation: PoppinAnimationProtocol, _ trigger: () -> Bool) {
        lifeCycleManager.addChild(animation, trigger: trigger)
    }
    
    func start() {
        hasCompleted = false
        self.lifeCycleManager.resetTriggers()
        self.registerKey = PoppinRegister.registerAnimation(self)
        delay(self.lifeCycleManager.delayInterval) {
            self.popAnimation.delegate = self
            self.object.pop_addAnimation(self.popAnimation, forKey: self.key)
        }
    }

    func registerForApply(handler: () -> Void) {
        self.lifeCycleManager.registerForApply(handler,  anim: self)
    }
    
    func registerForCompletion(handler: () -> Void) {
        self.lifeCycleManager.registerForCompletion(handler,  anim: self)
    }
    
    var isComplete:Bool {
        return self.hasCompleted
    }
    
    // MARK: POPAnimationDelegate
    
    func pop_animationDidApply(anim: POPAnimation!) {
        self.lifeCycleManager.checkTriggers()
        self.lifeCycleManager.nofityApply()
    }
    
    func pop_animationDidStop(anim: POPAnimation!, finished: Bool) {
        handleCompletion()
        PoppinRegister.removeAnimation(self.registerKey!)
    }
    
    
    // MARK: Helpers
    func handleCompletion() {
        if !self.hasCompleted {
            self.hasCompleted = true
            self.lifeCycleManager.checkTriggers()
            for h in self.lifeCycleManager.completionHandlers {
                h()
            }
            for c in lifeCycleManager.completionChildren {
                c.start()
            }
        }
        
    }
}


class PoppinAnimationTriggerBuilder {
    
    let animation: PoppinAnimationProtocol
    let prev: PoppinAnimationProtocol
    
    init(prev: PoppinAnimationProtocol, animation: PoppinAnimationProtocol) {
        self.animation = animation
        self.prev = prev
    }
    
    func on(t: () -> Bool) -> PoppinAnimationProtocol {
        prev.addEdge(animation, t)
        return animation
    }

}

infix operator ~> {
    associativity left
    precedence 155
}

infix operator ~>> {
    associativity left
    precedence 155
}


func ~> (left:PoppinAnimationProtocol, right:PoppinAnimationProtocol) -> PoppinAnimationProtocol {
    left.addEdge(right)
    return right
}


func ~>> (left:PoppinAnimationProtocol, right:PoppinAnimationProtocol) -> PoppinAnimationTriggerBuilder {
    return PoppinAnimationTriggerBuilder(prev: left, animation: right)
}

