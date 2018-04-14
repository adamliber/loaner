//
//  Item.swift
//  Neighborly
//
//  Created by Other users on 4/11/18.
//  Copyright © 2018 Adam Liber. All rights reserved.
//

import Foundation

class Item: NSObject {
    
    public var itemName:String
    public var itemDescription:String
 
    init(name: String, description: String){
        
        self.itemName = name
        self.itemDescription = description
        
    }
}
