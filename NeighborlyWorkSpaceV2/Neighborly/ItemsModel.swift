//
//  Items.swift
//  Neighborly
//
//  Created by Other users on 4/11/18.
//  Copyright © 2018 Adam Liber. All rights reserved.
//

import Foundation

class ItemsModel{
    
    static let shared = ItemsModel()
    public var borrowedItems: [Item]
    public var myItems: [Item]
    
    public init(){
        borrowedItems = [Item]()
        myItems = [Item]()
        borrowedItems.append(Item(name: "Camera", description: "Nikon for days my brother, this is the thing you. Relax snaphshot every dream you've ever had or ever will have"))
        myItems.append(Item(name: "Drill", description: "This is the best Drill you will ever see in your entire life if you don't borrow this drill your life will never be complete"))
        
    }
}
