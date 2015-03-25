//
//  GroupedPoppinAnimation.swift
//  Poppin
//
//  Created by Kelton Person on 3/13/15.
//  Copyright (c) 2015 Poppin. All rights reserved.
//

import Foundation

class GroupedPoppinAnimation : PoppinAnimationProtocol {
    
    let animations: [PoppinAnimationProtocol]
    var completionCount = 0
    private let lifeCycleManager = PoppinLifeCylceManager()
    private var hasFinished = false
    
    init(_ animations: PoppinAnimationProtocol...) {
        self.animations = animations
    }
    
    func start() {
        self.hasFinished = false
        self.lifeCycleManager.resetTriggers()
        delay(self.lifeCycleManager.delayInterval) {
            for a in self.animations {
                a.registerForCompletion(self.handleCompletedAnimation)
                a.registerForApply(self.handleAppliedAnimation)
                a.start()
            }
        }
    }
    
    func registerForApply(handler: () -> Void) {
        self.lifeCycleManager.registerForApply(handler,  anim: self)
    }
    
    func registerForCompletion(handler: () -> Void) {
        lifeCycleManager.registerForCompletion(handler, anim: self)
    }
    
    func delayAnimation(interval: NSTimeInterval) -> PoppinAnimationProtocol {
        return lifeCycleManager.delayAnimation(interval, anim: self)
    }
    
    func addEdge(animation: PoppinAnimationProtocol) {
        lifeCycleManager.addChild(animation)
    }
    
    func addEdge(animation: PoppinAnimationProtocol, _ trigger: () -> Bool) {
        lifeCycleManager.addChild(animation, trigger: trigger)
    }
    
    func handleCompletedAnimation() {
        if isComplete && !hasFinished {
            self.hasFinished = true
            handleCompletion()
        }
    }
    
    func handleAppliedAnimation() {
        self.lifeCycleManager.checkTriggers()
        self.lifeCycleManager.nofityApply()
    }
    
    func handleCompletion() {
        for h in lifeCycleManager.completionHandlers {
            h()
        }
        for c in lifeCycleManager.completionChildren {
            c.start()
        }
    }
    
    var isComplete:Bool {
        return animations.filter { x in x.isComplete }.count == self.animations.count
    }
    
}