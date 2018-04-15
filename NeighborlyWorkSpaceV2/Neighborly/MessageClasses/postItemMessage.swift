//
//  postItemMessage.swift
//  Neighborly
//
//  Created by Other users on 4/15/18.
//  Copyright © 2018 Adam Liber. All rights reserved.
//

import Foundation

class PostItemMessage:Codable{
    
    var messageID:String
    var ownerID:NSInteger
    var itemName:String
    var itemDescription:String
    var longitude:Double
    var latitude:Double
    
    init(messageID:String, ownerID:NSInteger, itemName:String, itemDescription:String, longitude:Double, latitude:Double ){
        
        self.messageID = messageID
        self.ownerID = ownerID
        self.itemName = itemName
        self.itemDescription = itemDescription
        self.longitude = longitude
        self.latitude = latitude
        
    }
    
    
}
