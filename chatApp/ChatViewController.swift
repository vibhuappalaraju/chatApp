//
//  ChatViewController.swift
//  chatApp
//
//  Created by Vibhu Appalaraju on 9/30/18.
//  Copyright © 2018 Vibhu Appalaraju. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chatMessageField: UITextField!
    var messagesArray = [PFObject]()
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        if let user = messagesArray[indexPath.row]["user"] as? PFUser {
            // User found! update username label with username
            cell.usernameLabel.text = user.username
        } else {
            // No user found, set default username
            cell.usernameLabel.text = "🤖"
        }
        cell.chatLabel?.text = messagesArray[indexPath.row]["text"] as? String
       return cell
    }
    

   
    
    override func viewDidLoad() {
    tableView.delegate = self
    tableView.dataSource = self
    // Auto size row height based on cell autolayout constraints
    tableView.rowHeight = UITableViewAutomaticDimension
    // Provide an estimated row height. Used for calculating scroll indicator
    tableView.estimatedRowHeight = 100
    Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @objc func onTimer() {
        // Retrieve the latest messages and reload the table
        
        let query = PFQuery(className: "Message")
        query.includeKey("user")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                print("objects found")
                
                if let objects = objects {
                    self.messagesArray = objects
                    self.tableView.reloadData() // call reload data here so that it's called only when your findObjectsInBackground finishes
                    
                }
            }
        }
        // Add code to be run periodically
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendButton(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = chatMessageField.text ?? ""
        chatMessage["user"] = PFUser.current()
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                 self.chatMessageField.text = ""
                 //self.refreshData()
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
           
        }
    }
    
    @IBAction func logoutButton(_ sender: Any) {
      NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
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
