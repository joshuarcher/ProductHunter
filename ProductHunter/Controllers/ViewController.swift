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
import SafariServices

private var numberOfCards: UInt = 5

class ViewController: UIViewController {
    
    let API = ProductHuntAPI()
    let postsManager = PostsEndpoint()
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
        
        postsManager.list().then { (promisedPosts: [PostJSON]) in
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
    
    private func openSafari(forUrl url: String) {
        let svc = SFSafariViewController(URL: NSURL(string: url)!)
        svc.modalPresentationStyle = .OverCurrentContext
        self.presentViewController(svc, animated: true, completion: nil)
    }


}

// MARK: KolodaViewDelegate
extension ViewController: KolodaViewDelegate {
    
    func koloda(koloda: KolodaView, didSwipedCardAtIndex index: UInt, inDirection direction: SwipeResultDirection) {
        if index >= 10 {
            swipeView.reloadData()
        }
    }
    
    func koloda(kolodaDidRunOutOfCards koloda: KolodaView) {
        swipeView.resetCurrentCardIndex()
    }
    
    func koloda(koloda: KolodaView, didSelectCardAtIndex index: UInt) {
        guard let posts = self.posts else { return }
        let post = posts[Int(index)]
        openSafari(forUrl: post.discussion_url!)
    }
    
    func koloda(kolodaShouldTransparentizeNextCard koloda: KolodaView) -> Bool {
        return false
    }
}

// MARK: KolodaViewDataSource
extension ViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(koloda: KolodaView) -> UInt {
        guard let posts = self.posts else { return 0 }
        return UInt(posts.count)
    }
    
    func koloda(koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        guard let posts = self.posts else { return UIView() }
        let post = posts[Int(index)]
        return ProductCardView.loadNib(withLabel: post.name!, tagline: post.tagline!, imageUrl: post.thumbnail_url!)
    }
    
    func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
        return nil
    }
}
