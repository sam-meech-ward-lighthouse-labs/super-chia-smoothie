//
//  ViewController.swift
//  SuperChiaSmoothie
//
//  Created by Sam Meech-Ward on 2018-09-18.
//  Copyright © 2018 meech-ward. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
    var levelOfSpiritualEnlightenment = "Chocra"
    
    // Nirvilla
    // Save to server
    guard let json = try? JSONSerialization.data(withJSONObject: ["levelOfSpiritualEnlightenment": levelOfSpiritualEnlightenment], options: []) else {
      print("wtf")
      return
    }
    
    let url = URL(string: "http://localhost:3000/levelOfSpiritualEnlightenment")!
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")  // the request is JSON
    urlRequest.httpBody = json
    
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
      print("Done \(String(describing: error))")
    }
    
    dataTask.resume()
  }
  
  @IBAction func load(_ sender: Any) {
    // Get all of the levelsOfSpiritualEnlightenment from the server
    // reload the table view
    
    let url = URL(string: "http://localhost:3000/levelOfSpiritualEnlightenment")!
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
      guard let data = data,
        let jsonAny = try? JSONSerialization.jsonObject(with: data, options: []),
        let json = jsonAny as? [String] else {
          print("Something wrong with data")
          return
      }
  
//      let name = json["levelOfSpiritualEnlightenment"]!
      
      self.names = json
      OperationQueue.main.addOperation {
        self.tableView.reloadData()
      }
    }
    
    dataTask.resume()
  }
}

extension ViewController: UITableViewDataSource {
  
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


