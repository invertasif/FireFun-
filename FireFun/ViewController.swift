//
//  ViewController.swift
//  FireFun
//
//  Created by Asif Ikbal on 5/16/17.
//  Copyright © 2017 Asif Ikbal. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    
    var ref:FIRDatabaseReference?
    var myList:[String] = []
    var dataHandel:FIRDatabaseHandle?
    
    @IBAction func saveButton(_ sender: Any) {
       
        
        // Saving item to the database
        if myTextField.text != "" {
            ref?.child("list").childByAutoId().setValue(myTextField.text)
            myTextField.text = ""
            
        }
        
        
    }
    
    // Setting up our table view 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = myList[indexPath.row]
        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ref = FIRDatabase.database().reference()
        dataHandel = ref?.child("list").observe(.childAdded, with: { (snapshot) in
            if let item = snapshot.value as? String {
                self.myList.append(item)
                self.myTableView.reloadData()
                
            }
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

