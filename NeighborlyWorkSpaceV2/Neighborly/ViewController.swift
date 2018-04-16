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
        let searchItemMessage = SearchItemMessage(searchTerm: "", longitude: 1.0, latitude: 1.0, distance: 5 )
        let encoder = JSONEncoder()
        
        do{
            let data = try encoder.encode(searchItemMessage)
            socket.write(string: String(data: data, encoding: .utf8)!)
            
        }catch{
            
        }
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
        
        let jsonText = text.data(using: .utf8)!
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

