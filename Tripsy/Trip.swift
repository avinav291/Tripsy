//
//  Trip.swift
//  Tripsy
//
//  Created by Avinav Goel on 20/02/16.
//  Copyright © 2016 Avinav Goel. All rights reserved.
//


import Foundation
import UIKit

class Trip {
//    var tripId = ""
    var city = ""
//    var country = ""
//    var featuredImage:PFFile?
    var price:Int = 0
//    var totalDays:Int = 0
//    var isLiked = false
    
    init(city: String, price: Int) {
        self.city = city
        self.price = price
    }
    
}