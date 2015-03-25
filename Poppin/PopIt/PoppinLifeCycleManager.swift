//
//  PoppinLifeCycleManager.swift
//  Poppin
//
//  Created by Kelton Person on 3/13/15.
//  Copyright (c) 2015 Poppin. All rights reserved.
//

import Foundation

class TriggeredChild {
    
    let child: PoppinAnimationProtocol
    let trigger: () -> Bool
    var isTriggered: Bool
    
    init(child: PoppinAnimationProtocol, trigger: () -> Bool) {
        self.child = child
        self.trigger = trigger
        self.isTriggered = false
    }
}


class PoppinLifeCylceManager {
    
    var delayInterval: NSTimeInterval = 0
    var completionChildren: [PoppinAnimationProtocol] = []
    var triggeredChildren: [TriggeredChild] = []
    var completionHandlers: [() -> ()] = []
    var applyHandlers: [() -> ()] = []

    
    init() {
    }
    
    func registerForCompletion(handler: () -> (), anim: PoppinAnimationProtocol) {
        self.completionHandlers.append(handler)
    }
    
    func registerForApply(handler: () -> (), anim: PoppinAnimationProtocol) {
        self.applyHandlers.append(handler)
    }
    
    func delayAnimation(interval: NSTimeInterval, anim: PoppinAnimationProtocol) -> PoppinAnimationProtocol {
        self.delayInterval = interval
        return anim
    }
    
    func addChild(animation: PoppinAnimationProtocol) {
        completionChildren.append(animation)
    }
    
    func addChild(animation: PoppinAnimationProtocol, trigger:() -> Bool) {
        triggeredChildren.append(TriggeredChild(child: animation, trigger: trigger))
    }
    
    func checkTriggers() {
        triggeredChildren.filter { x in !x.isTriggered }.foreach { t in
            if t.trigger() {
                t.isTriggered = true
                t.child.start()
            }
        }
    }
    
    func resetTriggers() {
        triggeredChildren.foreach { c in c.isTriggered = false }
    }
    
    func nofityApply() {

        applyHandlers.foreach { h in h() }
    }
    
}