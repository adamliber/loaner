//
//  SearchItemMessage.swift
//  Neighborly
//
//  Created by Other users on 4/15/18.
//  Copyright © 2018 Adam Liber. All rights reserved.
//

import Foundation

class SearchItemMessage:Codable{
    
    var messageID:String
    var searchString:String
    var longitude:Double
    var latitude:Double
    var distanceMiles:NSInteger
    
    init( searchString:String, longitude:Double, latitude:Double, distanceMiles: NSInteger){
        
        self.messageID = "searchItem"
       self.searchString = searchString
        self.longitude = longitude
        self.latitude = latitude
        self.distanceMiles = distanceMiles
    }
    
    
}
