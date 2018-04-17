//
//  Item.swift
//  Neighborly
//
//  Created by Other users on 4/11/18.
//  Copyright © 2018 Adam Liber. All rights reserved.
//

import Foundation

class Item: NSObject,Codable {
    
    public var itemName:String
    public var itemID: NSInteger
    public var available: NSInteger
   
    public var itemDescription:String?
    public var latitude:Double
    public var longitude:Double
    public var ownerID: NSInteger
    public var borrowerID: NSInteger
    
    init(name: String,itemID: NSInteger, available:NSInteger, description: String,longitude:Double,latitude:Double, ownerID: NSInteger, borrowerID: NSInteger){
        self.itemName = name
        self.itemID = itemID
        self.available = available
        self.itemDescription = description
       
        self.latitude = latitude
        self.longitude = longitude
        self.ownerID = ownerID
        self.borrowerID = borrowerID
        
        
    }
}
