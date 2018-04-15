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
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        socket.delegate = self
        
        
    }
    
    deinit {
        
        socket.delegate = nil
    }
   
    func websocketDidConnect(socket: WebSocketClient) {
        print("viewController socket is connected")
       
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("viewController socket is disconnected: \(String(describing: error?.localizedDescription))")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        
        print("viewController some text: \(text)")
        let trunc = String(text.dropLast(1).dropFirst(1) )
        print(trunc)
        let jsonText = trunc.data(using: .utf8)!
        let decoder = JSONDecoder()
        
        let item = try? decoder.decode(Item.self, from: jsonText)
        
        print(item?.itemName)
    
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("viewController got some data: \(data.count)")
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

