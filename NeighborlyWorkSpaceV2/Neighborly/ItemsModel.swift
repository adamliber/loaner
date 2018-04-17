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
    
    public func setBorrowedItems(items: [Item]){
        self.borrowedItems = items
    }
    public func setMyItems(items: [Item]){
        self.myItems = items
    }
    
    public init(){
        borrowedItems = [Item]()
        myItems = [Item]()
       
        borrowedItems.append(Item(name: "Camera", itemID: 1, available: 1, description: "Good Camera", longitude: 6.7, latitude: 7.8, ownerID: 1, borrowerID: 2   ) )
            
        myItems.append(Item(name: "drill", itemID: 1, available: 1, description: "Good Camera", longitude: 6.7, latitude: 7.8, ownerID: 1, borrowerID: 2   ) )
       
        
    }
}
