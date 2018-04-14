//
//  LeftSideMenuViewController.swift
//  Neighborly
//
//  Created by Other users on 4/2/18.
//  Copyright © 2018 Adam Liber. All rights reserved.
//

import UIKit

class LeftSideMenuViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    var menuItems:[String] = ["Search Items", "Account", "Messages" ,"Groups", "About" ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableViewCell
        cell.menuItemLabel.text = menuItems[indexPath.row]
        return cell
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        switch(indexPath.row){
            case 0:
                let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                let mainNavController = UINavigationController(rootViewController: mainViewController)
                let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.centerContainer!.centerViewController = mainNavController
                appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
                break;
            case 1:
                let accountViewController = self.storyboard?.instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
                let accountNavController = UINavigationController(rootViewController: accountViewController)
                let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.centerContainer!.centerViewController = accountNavController
                appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
            case 4:
                let aboutViewController = self.storyboard?.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
                let aboutNavController = UINavigationController(rootViewController: aboutViewController)
                let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.centerContainer!.centerViewController = aboutNavController
                appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)

                break;
        default:
            print("other menu cell selected")
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
