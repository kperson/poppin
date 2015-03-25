//
//  ViewController.swift
//  Poppin
//
//  Created by Kelton Person on 3/13/15.
//  Copyright (c) 2015 Poppin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let square = UIView(frame: CGRectMake(0, 0, 100, 100))
        square.backgroundColor = UIColor.orangeColor()
        view.addSubview(square)
        
        let m1 = PoppinSpringBuilder(propertyName: kPOPLayerPosition).to(CGPointMake(200, 200)).bounciness(10).build()
        let m2 = PoppinBasicBuilder(propertyName: kPOPLayerPosition).to(CGPointMake(50, 50)).time(1.second).build()
        
        let a1 = PoppinAnimation(animation: m1, object: square, key: "m1")
        let a2 = PoppinAnimation(animation: m2, object: square, key: "m2")
        
        
        let (screen, fade) = alphaScreen(view, alpha: 0.8, timeInterval: 3.second)
        
        let x = GroupedPoppinAnimation(fade, a1)
        x ~> a2 ~> a1 ~> a2
        x.start()
        
    }
    
    
    func alphaScreen(aView: UIView, alpha: CGFloat, baseColor: UIColor = UIColor.blackColor(), timeInterval: NSTimeInterval = 400.milliseconds) -> (UIView, PoppinAnimation) {
        let screen = UIView(frame: aView.bounds)
        screen.backgroundColor = baseColor
        screen.alpha = 0
        aView.addSubview(screen)
        let alpaAnim = PoppinBasicBuilder(propertyName: kPOPViewAlpha).to(alpha).time(timeInterval).build()
        let poppinAnim = PoppinAnimation(animation: alpaAnim, object: screen, key: "alphaScreenFade")
        return (screen, poppinAnim)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

