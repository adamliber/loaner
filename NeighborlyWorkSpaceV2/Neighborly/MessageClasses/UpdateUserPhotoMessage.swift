//
//  UpdateUserPhotoMessage.swift
//  Neighborly
//
//  Created by Other users on 4/16/18.
//  Copyright © 2018 Adam Liber. All rights reserved.
//

import Foundation

class UpdateUserPhotoMessage:Codable{
    
    var messageID:String
    var userID:NSInteger
    var image:String
    init(userID:NSInteger,image:String){
        self.messageID = "updateUserPhoto"
        self.image = image
        self.userID = userID
    }
}
