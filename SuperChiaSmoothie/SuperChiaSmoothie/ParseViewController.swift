//
//  ViewController.swift
//  SuperChiaSmoothie
//
//  Created by Sam Meech-Ward on 2018-09-18.
//  Copyright © 2018 meech-ward. All rights reserved.
//

import UIKit
import Parse

class ParseViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var names: [String] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func add(_ sender: Any) {
    
    var drink = PFObject(className:"Drinks")
    drink["name"] = "Nirvilla"
    drink["size"] = 2
    drink["ingredients"] = ["🤗", "💩"]
    
    drink.saveInBackground {
      (success: Bool, error: Error?) in
      if (success) {
        print("🤗")
      } else {
        print("🤷‍♂️")
      }
    }

  }
  
  @IBAction func load(_ sender: Any) {
    var query = PFQuery(className:"Drinks")
    query.findObjectsInBackground { (objects, error) in
      guard let objects = objects else {
        print("Err")
        return
      }
      
      self.names = objects.map({ (drink: PFObject) -> String in
        return drink["name"] as! String
      })
      
      OperationQueue.main.addOperation {
        self.tableView.reloadData()
      }
    }
  }
}

extension ParseViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return names.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
    
    let name = names[indexPath.row]
    cell.textLabel?.text = name
    
    return cell
  }
  
}


