//
//  ProductCardView.swift
//  ProductHunter
//
//  Created by Joshua Archer on 3/31/16.
//  Copyright © 2016 Joshua Archer. All rights reserved.
//

import UIKit

class ProductCardView: UIView {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productTagline: UILabel!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    
    class func loadNib(withLabel name: String, tagline: String, imageUrl: String) -> UIView {
        let productView = UINib(nibName: "ProductCardView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! ProductCardView
        productView.productName.text = name
        productView.productTagline.text = tagline
        productView.innerView.layer.cornerRadius = 10
        productView.innerView.layer.masksToBounds = true
        productView.innerView.layer.borderColor = UIColor.lightGrayColor().CGColor
        productView.innerView.layer.borderWidth = 0.1
        productView.layer.shadowColor = UIColor.grayColor().CGColor
        productView.layer.shadowOpacity = 0.8
        productView.layer.shadowRadius = 3
        productView.layer.shadowOffset = CGSizeMake(0, 1)
        productView.layer.masksToBounds = false
        productView.downloadImage(fromURL: imageUrl)
        return productView
    }
    
    func downloadImage(fromURL url: String) {
        self.productImage.imageFromUrl(url)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
