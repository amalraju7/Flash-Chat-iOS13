//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    var messages = [Message(sender: "Rahul", body: "Hello"),Message(sender: "Rahul", body: "Hi"),Message(sender: "Rahul", body: "Wassup"),]
    let db = Firestore.firestore()
    override func viewDidLoad() {
        title = K.title
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        tableView.dataSource = self
        super.viewDidLoad()
        loadMessages()

    }
    
    func loadMessages(){
        
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { querySnapshot, error in
            self.messages = []
            if let e = error{
                print(e)
            }
            else{
                for document in querySnapshot!.documents{
                    let data = document.data()
                    if let sender = data[K.FStore.senderField] as? String, let body = data[K.FStore.bodyField] as? String{
                        let message = Message(sender: sender, body: body)
                        self.messages.append(message)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                    
                    
                }
            
          
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        let messageBody = messageTextfield.text
        let messageSender = Auth.auth().currentUser
        if let messageBody = messageBody, let messageSender = messageSender{
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender.uid,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added ")
                }
            }
            
        }
        
     

        
    }
    

}

extension ChatViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell  = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = messages[indexPath.row].body
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    
}
