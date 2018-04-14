//
//  ViewController.swift
//  Neighborly
//
//  Created by Other users on 4/1/18.
//  Copyright © 2018 Adam Liber. All rights reserved.
//

import UIKit
import Starscream


class ViewController: UIViewController , WebSocketDelegate {
    
    
    
    
    
    
    public var socket = WebSocket(url: URL(string: "ws://localhost:8080/NeighbourlyServer/ws")!,protocols: ["chat"] )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        socket.delegate = self
        socket.connect()
        
    }
    
    deinit {
        socket.disconnect(forceTimeout: 0)
        socket.delegate = nil
    }
   
    func websocketDidConnect(socket: WebSocketClient) {
        print("web socket is connected")
        socket.write(string: "Hi server!")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("web socket is disconnected: \(String(describing: error?.localizedDescription))")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        struct AItem: Codable {
            
              var itemName:String
              var itemID: NSInteger
              var availibility: NSInteger
              var imageURL: String
              var itemDescription:String?
            var latitude:Double
              var longitude:Double
            
              var ownerID: NSInteger
              var borrowerID: NSInteger
            
        }
        print("got some text: \(text)")
        let trunc = String(text.dropLast(1).dropFirst(1) )
        print(trunc)
        let jsonText = trunc.data(using: .utf8)!
        let decoder = JSONDecoder()
        
             let item = try? decoder.decode(Item.self, from: jsonText)
        
        print(item?.itemName)
    
    
        
        
        
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("got some data: \(data.count)")
    }
   
    
   
    @IBAction func MenuTapped(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate  as! AppDelegate
        appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    

}

