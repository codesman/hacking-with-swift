//
//  ViewController.swift
//  Petitions
//
//  Created by Tom Holland on 5/7/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    lazy var petitions = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getData()
    }

    private func getData(){
        guard let url = URL(string: "https://api.whitehous.gov/v1/petitions.json?limit=100" ) else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        
        parse(json: JSON(data: data))
    }
    
    private func parse(json: JSON) {
        guard json["metadata"]["responseInfo"]["status"].intValue == 200 else { return }
        
        for result in json["results"].arrayValue {
            let title = result["title"].stringValue
            let body = result["body"].stringValue
            let signatureCount = result["signatureCount"].stringValue
            let petition = ["title": title, "body": body, "signatureCount": signatureCount]
            
            petitions.append(petition)
        }
        
        tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = "Title Goes Here"
        cell.detailTextLabel?.text = "Subtitle Goes Here"
        
        return cell
    }
}

