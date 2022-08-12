//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let messages = [Message(sender: "Rahul", body: "Hello"),Message(sender: "Rahul", body: "Hi"),Message(sender: "Rahul", body: "Wassup"),]
    
    override func viewDidLoad() {
        title = K.title
        super.viewDidLoad()

    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
    }
    

}
