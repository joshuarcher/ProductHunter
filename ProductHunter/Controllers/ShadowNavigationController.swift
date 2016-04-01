//
//  ShadowNavigationController.swift
//  ProductHunter
//
//  Created by Joshua Archer on 3/31/16.
//  Copyright © 2016 Joshua Archer. All rights reserved.
//

import UIKit

class ShadowNavigationController: UINavigationController {

    override func viewWillAppear(animated: Bool) {
        let darkColor: CGColorRef = UIColor.lightGrayColor().CGColor
        let lightColor: CGColorRef = UIColor.clearColor().CGColor
        let navigationBarBottom: CGFloat = self.navigationBar.frame.origin.y + self.navigationBar.frame.size.height + 20
        
        let newShadow: CAGradientLayer = CAGradientLayer()
        newShadow.frame = CGRectMake(0, navigationBarBottom, self.view.frame.size.width, 1.5)
        newShadow.colors = [darkColor, lightColor]
        newShadow.opacity = 0.8
        self.view.layer.addSublayer(newShadow)
        
        super.viewWillAppear(animated)
    }

}
