//
//  persistance.swift
//  Neighborly
//
//  Created by Other users on 4/15/18.
//  Copyright © 2018 Adam Liber. All rights reserved.
//

import Foundation


func getPath()->String{
    let plistFileName = "data.plist"
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentPath = paths[0] as NSString
    let plistPath = documentPath.appendingPathComponent(plistFileName)
    return plistPath
}


