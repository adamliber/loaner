//
//  PostViewController.swift
//  Neighborly
//
//  Created by Other users on 4/9/18.
//  Copyright © 2018 Adam Liber. All rights reserved.
//

import UIKit
import Starscream
class PostViewController: UIViewController, UITextFieldDelegate,UITextViewDelegate,WebSocketDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    
    
    public func loadUser() -> User?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: User.ArchiveURL.path) as? User
    }
    
    
    public var user:User?
    func websocketDidConnect(socket: WebSocketClient) {
        print("post socket connected")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("post socket disconnected")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("post received text: \(text)")
        let jsonText = text.data(using: .utf8)!
        let decoder = JSONDecoder()
        let message = try! decoder.decode(Message.self, from: jsonText)
        print("message received:  \(message.message)" )
        
        if(message.message == "valid"){
            print("should dismiss")
            dismiss(animated: true, completion: nil)
    
        }
        
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("post received data \(data)" )
    }
    
    
    
    
    
    @IBOutlet weak var myImageView: UIImageView!
    
    
    @IBAction func importImage(_ sender: Any) {
        let imagePicked = UIImagePickerController()
        imagePicked.delegate = self
        
        imagePicked.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        imagePicked.allowsEditing = false
        imagePicked.modalPresentationStyle = .overCurrentContext
        self.present(imagePicked, animated: true){
            
        }
    }
    
    
        
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let imagePicked = info[UIImagePickerControllerOriginalImage] as? UIImage {
            myImageView.image = imagePicked
        
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var itemNameField: UITextField!
    
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var postButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        socket.delegate = self
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        self.user = loadUser()!
        itemNameField.delegate = self
        descriptionTextView.delegate = self
        postButton.isEnabled = false
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard) )
        self.view.addGestureRecognizer(singleTap)
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textView.text == "Description     "){
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if(itemNameField.text != "" && descriptionTextView.text != "" && descriptionTextView.text != "Description     "){
            postButton.isEnabled = true
        }else if(descriptionTextView.text == ""){
            descriptionTextView.textColor = UIColor.gray
            descriptionTextView.text = "Description     "
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(itemNameField.text != "" && descriptionTextView.text != "" && descriptionTextView.text != "Description     "){
            postButton.isEnabled = true
        }
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n"){
            self.view.endEditing(true)
            return false
        }
        return true
    }
    
    @IBAction func PostSubmitted(_ sender: Any) {
        
        let postItemMessage = PostItemMessage( ownerID: user!.userID , itemName: itemNameField.text!, itemDescription: itemNameField.text!, longitude: 1.0, latitude: 1.0)
        let encoder = JSONEncoder()
        
        do{
            let data = try encoder.encode(postItemMessage)
            socket.write(string: String(data: data, encoding: .utf8)!)
            //socket.write(data: <#T##Data#>)
            
        }catch{
            
        }
        
        
    }
    
    @IBAction func cancelPost(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
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
