//
//  ProductCardView.swift
//  ProductHunter
//
//  Created by Joshua Archer on 3/31/16.
//  Copyright © 2016 Joshua Archer. All rights reserved.
//

import UIKit

@IBDesignable
class ProductCardView: UIView {

    @IBOutlet weak var productName: UILabel!
    
    class func loadNib(withLabel labelText: String) -> UIView {
        let productView = UINib(nibName: "ProductCardView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! ProductCardView
        productView.productName.text = labelText
        return productView
    }
    
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
