//
//  AccountViewController.swift
//  Neighborly
//
//  Created by Avni Barman on 4/8/18.
//  Copyright © 2018 Adam Liber. All rights reserved.
//

import UIKit
import Starscream

class AccountViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, WebSocketDelegate{
   
    
    @IBOutlet weak var nameField: UILabel!
    
    
   
    func websocketDidConnect(socket: WebSocketClient) {
        print("accountinfo socket connected")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("accountinfo socket disconnected")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("account info received text: \(text)")
        let jsonText = text.data(using: .utf8)!
        let decoder = JSONDecoder()
        let userInfo = try! decoder.decode(UserInfoMessage.self, from: jsonText)
        print("userID received:  \(String(describing: userInfo.userID))" )
        print("message received:  \(userInfo.message)" )
        print("\nmy Items received: \(String(describing: userInfo.myItems?.first?.itemName))" )
        
        if(userInfo.message == "valid"){
            model.setMyItems(items: userInfo.myItems!)
            model.setBorrowedItems(items: userInfo.borrowedItems!)
            
            
        }
            
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("account info received data: \(data)")

    }
    
    
    public var user:User?
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    private var model = ItemsModel()
    
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate  as! AppDelegate
        appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        socket.delegate = self
        // Do any additional setup after loading the view.
        self.tableView.rowHeight = 134
        
        self.user = loadUser()
        self.nameField.text = user?.name
        let accountInfoMessage = AccountInfoMessage(userID: (user?.userID)!)
        let encoder = JSONEncoder()
        print("account view did load")
        do{
            let data = try encoder.encode(accountInfoMessage)
            socket.write(string: String(data: data, encoding: .utf8)!)
            
        }catch{
            
        }
        
    }
    
    @IBAction func segmentControlClicked(_ sender: Any) {
        tableView.reloadData();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        switch(segmentControl.selectedSegmentIndex){
        case 0:
            return model.borrowedItems.count
            
        case 1:
            return model.myItems.count
            
        default:
            break
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell( withIdentifier: "itemCard", for: indexPath) as! ItemCardTableViewCell
        switch(segmentControl.selectedSegmentIndex){
        case 0:
            cell.itemName.text = model.borrowedItems[indexPath.row].itemName
            cell.itemDetails.text = model.borrowedItems[indexPath.row].itemDescription
            if(model.borrowedItems[indexPath.row].available == 1){
                cell.itemStatusLabel.text = "Available"
                cell.itemStatusLabel.backgroundColor = UIColor.green
                cell.itemStatusLabel.textColor = UIColor.white
            }else{
                cell.itemStatusLabel.text = "Unavailable"
                cell.itemStatusLabel.backgroundColor = UIColor.red
                cell.itemStatusLabel.textColor = UIColor.white
            }
            cell.itemPhoto.image = UIImage(named:"DefaultItemCamera")
            break
        case 1:
            cell.itemName.text = model.myItems[indexPath.row].itemName
            cell.itemDetails.text = model.myItems[indexPath.row].itemDescription
            if(model.myItems[indexPath.row].available == 1){
                cell.itemStatusLabel.text = "Available"
                cell.itemStatusLabel.backgroundColor = UIColor.green
                cell.itemStatusLabel.textColor = UIColor.white
            }else{
                cell.itemStatusLabel.text = "Unavailable"
                cell.itemStatusLabel.backgroundColor = UIColor.red
                cell.itemStatusLabel.textColor = UIColor.white
            }
            cell.itemPhoto.image = UIImage(named:"DefaultItemDrill")
            break
        default:
            break
        }
        
        return cell
    }
    
}
