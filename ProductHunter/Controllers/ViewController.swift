//
//  ViewController.swift
//  ProductHunter
//
//  Created by Joshua Archer on 3/31/16.
//  Copyright © 2016 Joshua Archer. All rights reserved.
//

import UIKit
import Koloda
import SwiftyJSON
import PromiseKit

private var numberOfCards: UInt = 5

class ViewController: UIViewController {
    
    let API = ProductHuntAPI()
    var posts: [PostJSON]? {
        didSet {
            swipeView.reloadData()
        }
    }
    
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

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        API.getTechPosts().then { (promisedPosts: [PostJSON]) in
            self.posts = promisedPosts
        }
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
        if index >= 10 {
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
//        return numberOfCards
        guard let posts = self.posts else { return 0 }
        return UInt(posts.count)
    }
    
    func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        guard let posts = self.posts else { return UIView() }
        let post = posts[Int(index)]
        return ProductCardView.loadNib(withLabel: post.name!, tagline: post.tagline!)
    }
    
    func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
        return nil
    }
}
