//
//  TripViewController.swift
//  Tripsy
//
//  Created by Avinav Goel on 20/02/16.
//  Copyright © 2016 Avinav Goel. All rights reserved.
//

import UIKit

class TripViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate {
    @IBOutlet weak var backgroundImageView:UIImageView!
    @IBOutlet weak var collectionView:UICollectionView!
    
    
    var refreshControl :UIRefreshControl!
    
    private var trips: [Trip] = [Trip(city: "Manali", price: 2000), Trip(city: "Jaipur", price: 5000), Trip(city: "Kerala", price: 12000), Trip(city: "Bangalore", price: 122222)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.refreshControl = UIRefreshControl()
//        refreshControl.attributedTitle = NSAttributedString(string: "Pull Down To Refresh")
//        refreshControl.addTarget(self, action: "loadTrips:", forControlEvents: UIControlEvents.ValueChanged)
//        self.collectionView.addSubview(refreshControl)
//        self.collectionView.alwaysBounceHorizontal = true
        
        
        // Apply blurring effect
        backgroundImageView.image = UIImage(named: "cloud")
        let blurEffect = UIBlurEffect(style: .Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        self.collectionView.backgroundColor = UIColor.clearColor()
        
        if UIScreen.mainScreen().bounds.size.height == 480.0 {
            let flowLayout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            flowLayout.itemSize = CGSizeMake(250.0, 300.0)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trips.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! TripCollectionCell
        
        // Configure the cell
        cell.cityLabel.text = trips[indexPath.row].city
        cell.priceLabel.text = "\(String(trips[indexPath.row].price))"
        
        
        return cell
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
}