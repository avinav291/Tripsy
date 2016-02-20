//
//  TripCollectionCell.swift
//  Tripsy
//
//  Created by Avinav Goel on 20/02/16.
//  Copyright © 2016 Avinav Goel. All rights reserved.
//

import UIKit


class TripCollectionCell: UICollectionViewCell {
    @IBOutlet weak var cityLabel:UILabel!
    @IBOutlet weak var noOfDaysField:UITextField!
    @IBOutlet weak var priceLabel:UILabel!
    @IBOutlet weak var inviteButton:UIButton!
    @IBOutlet weak var totalExpenseLabel : UILabel!
    
    @IBAction func calculateExpenseButtonPressed(sender: AnyObject){
//        totalExpenseLabel.text = ((priceLabel.text!.toInt())*(noOfDaysField.text!.toInt()))
        if(noOfDaysField.isFirstResponder()){
            noOfDaysField.resignFirstResponder()
        }
        if let days = Int(noOfDaysField.text!)
        {
            if let price = Int(priceLabel.text!){
                totalExpenseLabel.text = String( price * days)
            }
            
        }
    }
    
//    var isLike:Bool = false  {
//        didSet {
//            if isLike {
//                likeButton.setImage(UIImage(named: "heartfull"), forState: .Normal)
//            } else {
//                likeButton.setImage(UIImage(named: "heart"), forState: .Normal)
//            }
//        }
//    }
//    var delegate:TripCollectionCellDelegate?
    
    
//    @IBAction func likeButtonTapped(sender: AnyObject) {
//        delegate?.didLikeButtonPressed(self)
//    }
    
}