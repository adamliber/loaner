//
//  AccountViewController.swift
//  Neighborly
//
//  Created by Avni Barman on 4/8/18.
//  Copyright © 2018 Adam Liber. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    private var model = ItemsModel()
    
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate  as! AppDelegate
        appDelegate.centerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableView.rowHeight = 134
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
            cell.itemDistanceFromCurrentUser.text = "100 miles"
            cell.itemPhoto.image = UIImage(named:"DefaultItemCamera")
            break
        case 1:
            cell.itemName.text = model.myItems[indexPath.row].itemName
            cell.itemDetails.text = model.myItems[indexPath.row].itemDescription
            cell.itemDistanceFromCurrentUser.text = "100 miles"
            cell.itemPhoto.image = UIImage(named:"DefaultItemDrill")
            break
        default:
            break
        }
        
        return cell
    }
    
}
