//
//  ViewController.swift
//  Petitions
//
//  Created by Tom Holland on 5/7/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

// TODO: Add more tabs - Doumentation: https://petitions.whitehouse.gov/developers

import UIKit

class ViewController: UITableViewController {
    
    lazy var petitions = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getData()
    }
    
    func urlString() -> String {
        guard let tag = navigationController?.tabBarItem.tag else { return "" }
        
        switch tag {
        case 1:
            return "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        case 2:
            return "https://api.whitehouse.gov/v1/petitions.json?title=trump&limit=100"
        default:
            return "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        }
    }
    
    private func getData(){
        
        DispatchQueue.global(qos: .userInitiated).async {
            [unowned self] in
            
            let urlString = self.urlString()
            
            guard let url = URL(string: urlString ) else { return }
            guard let data = try? Data(contentsOf: url) else { return }
            
            self.parse(json: JSON(data: data))
            
        }
    }
    
    private func parse(json: JSON) {
        guard json["metadata"]["responseInfo"]["status"].intValue == 200 else { showError(); return }
        
        for result in json["results"].arrayValue {
            let title = result["title"].stringValue
            let body = result["body"].stringValue
            let signatureCount = result["signatureCount"].stringValue
            let petition = ["title": title, "body": body, "signatureCount": signatureCount]
            
            petitions.append(petition)
        }
        
        DispatchQueue.main.async { [unowned self] in
            self.tableView.reloadData()
        }
    }
    
    func showError() {
        DispatchQueue.main.async { [unowned self] in
            
            let alert = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed. Please check your connection and try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            self.present(alert, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailViewController()
        
        viewController.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
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
        let petition = petitions[indexPath.row]
        
        cell.textLabel?.text = petition["title"]
        cell.detailTextLabel?.text = petition["body"]
        
        return cell
    }
}

