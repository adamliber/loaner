//
//  ViewController.swift
//  Neighborly
//
//  Created by Other users on 4/1/18.
//  Copyright © 2018 Adam Liber. All rights reserved.
//

import UIKit
import Starscream
import CoreLocation
import Cloudinary

class ViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource, WebSocketDelegate {
    
    private var model = ItemsModel.shared
    public var user:User?
    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var addPostButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = loadUser()
        if(user?.email == "guest" && addPostButton != nil){
            addPostButton.isEnabled = false
        }
        NotificationCenter.default.addObserver(self, selector: #selector(updateResults), name: NSNotification.Name(rawValue: "loadSearchResults"), object: nil)
        
        
        socket.delegate = self
        self.searchResultTableView?.rowHeight = 134
        let searchItemMessage = SearchItemMessage(searchTerm: "", longitude: 1.0, latitude: 1.0, distance: 5 )
        let encoder = JSONEncoder()
        
        do{
            let data = try encoder.encode(searchItemMessage)
            socket.write(string: String(data: data, encoding: .utf8)!)
        }catch{}
        updateResults()
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
        let message = try! decoder.decode(Message.self, from: jsonText)
        if(message.message == "invalid"){
            return
        }
        let itemList = try! decoder.decode(ItemList.self, from: jsonText)
        print("view controller received:  \(itemList.message)" )
        
        if(itemList.message == "valid"){
            
            model.setSearchResultItems(items: itemList.itemList)
            for item in itemList.itemList{
                print("\n\n\nitem url:   \(item.imageURL) ")
                
            }
            if(searchResultTableView != nil){
                searchResultTableView.reloadData()
            }
            
            
        }
        
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("viewController got some data: \(data.count)")
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("table view rows")
        return model.searchResultItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let item = model.searchResultItems[indexPath.row]
            let cell =  tableView.dequeueReusableCell( withIdentifier: "itemCard", for: indexPath) as! ItemCardTableViewCell
       
            cell.itemName.text = item.itemName
            cell.itemDetails.text = item.itemDescription
        
        
        
            let userCoordinate = CLLocation(latitude: 1.0, longitude: 1.0)
            let itemCoordinate = CLLocation(latitude: item.latitude, longitude: item.longitude)
        
        
            let distanceInMeters = userCoordinate.distance(from: itemCoordinate)
            var distanceInMiles:NSInteger = NSInteger(distanceInMeters/1609)
        
            distanceInMiles = item.ownerID
        
            cell.itemStatusLabel.text = String(distanceInMiles) + " miles"
        
            
            if(item.imageURL != ""){
                let url = URL(string: item.imageURL)
                let data = try? Data(contentsOf: url!)
                cell.itemPhoto.image =  UIImage(data: data!)
            }
        
        
            if(item.ownerID == user?.userID){
                let label = cell.itemStatusLabel
                label?.text = "My Item"
                label?.backgroundColor = UIColor.blue
                label?.textColor = UIColor.white
                label?.layer.cornerRadius = 6
                label?.layer.masksToBounds = true
                
            }
        
        
        
            return cell
    }
   
    
    @objc func updateResults(){
        print("\n\nupdate results")
        
        if(searchResultTableView != nil){
            searchResultTableView.reloadData()
        }
    }
    
    
    deinit {
        print("viewcontroller deinit called")
        socket.delegate = nil
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

