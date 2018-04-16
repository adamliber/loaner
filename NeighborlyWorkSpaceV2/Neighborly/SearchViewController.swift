//
//  SearchViewController.swift
//  Neighborly
//
//  Created by Other users on 4/9/18.
//  Copyright © 2018 Adam Liber. All rights reserved.
//

import UIKit
import Starscream


class SearchViewController: UIViewController, UITextFieldDelegate, WebSocketDelegate {
    func websocketDidConnect(socket: WebSocketClient) {
        print("Search Socket connected")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("Search Socket disconnected")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("search Socket received text: \(text)")
        
        let jsonText = text.data(using: .utf8)!
        let decoder = JSONDecoder()
        let itemList = try! decoder.decode(ItemList.self, from: jsonText)
        print("message received:  \(itemList.message)" )
        
        if(itemList.message == "valid"){
            print("should dismiss")
            dismiss(animated: true, completion: nil)
            
        }
    }
    
    @IBOutlet weak var searchButton: UIButton!
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("search Socket received data: \(data)")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if( itemSearchField.text != "" && searchLocationField.text != "" ){
            searchButton.isEnabled = true
        }
    }
    
    @IBOutlet weak var searchModalView: UIView!
    
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var itemSearchField: UITextField!
    @IBOutlet weak var searchLocationField: UITextField!
    
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        distanceLabel.text = "Max Distance: \(NSInteger(distanceSlider.value))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        socket.delegate = self
        searchModalView.layer.cornerRadius = 10
        searchModalView.layer.masksToBounds = true
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cancelSearch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchSubmitted(_ sender: Any) {
        let searchItemMessage = SearchItemMessage(searchTerm: itemSearchField.text!, longitude: 1.0, latitude: 1.0, distance: NSInteger(distanceSlider.value) )
        let encoder = JSONEncoder()
        
        do{
            let data = try encoder.encode(searchItemMessage)
            socket.write(string: String(data: data, encoding: .utf8)!)
            
        }catch{
            
        }
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
