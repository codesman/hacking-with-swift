//
//  ViewController.swift
//  StormViewer
//
//  Created by Tom Holland on 5/2/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    lazy var images = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let manager = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! manager.contentsOfDirectory(atPath: path)
        
        for item in items {
            guard item.hasPrefix("nssl") else { continue }
            
            images.append(item)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

