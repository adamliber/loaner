//
//  Socket.swift
//  Neighborly
//
//  Created by Other users on 4/13/18.
//  Copyright © 2018 Adam Liber. All rights reserved.
//

import Foundation
import Starscream

public var socket = WebSocket(url: URL(string: "ws://localhost:8080/NeighbourlyServer/ws")!,protocols: ["chat"] )



