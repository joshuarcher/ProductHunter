//
//  ViewController.swift
//  ProductHunter
//
//  Created by Joshua Archer on 3/31/16.
//  Copyright © 2016 Joshua Archer. All rights reserved.
//

import UIKit
import Koloda

private var numberOfCards: UInt = 5

class ViewController: UIViewController {
    
    // MARK: - View Lifecycle
    
    @IBOutlet weak var swipeView: KolodaView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwipeView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    private func setupSwipeView() {
        swipeView.dataSource = self
        swipeView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func leftCenterTapped(sender: AnyObject) {
        swipeView.swipe(.Left)
    }
    
    @IBAction func rightCenterTapped(sender: AnyObject) {
        swipeView.swipe(.Right)
    }


}

// MARK: KolodaViewDelegate
extension ViewController: KolodaViewDelegate {
    
    func koloda(koloda: KolodaView, didSwipedCardAtIndex index: UInt, inDirection direction: SwipeResultDirection) {
        //Example: loading more cards
        if index >= 3 {
            numberOfCards = 6
            swipeView.reloadData()
        }
    }
    
    func koloda(kolodaDidRunOutOfCards koloda: KolodaView) {
        //Example: reloading
        swipeView.resetCurrentCardNumber()
    }
    
    func koloda(koloda: KolodaView, didSelectCardAtIndex index: UInt) {
        UIApplication.sharedApplication().openURL(NSURL(string: "recall-that.com")!)
    }
}

// MARK: KolodaViewDataSource
extension ViewController: KolodaViewDataSource {
    
    func koloda(kolodaNumberOfCards koloda:KolodaView) -> UInt {
        return numberOfCards
    }
    
    func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        return ProductCardView.loadNib(withLabel: "Abot", tagline: "Build your own digital assisstant")
    }
    
    func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
        return nil
    }
}
