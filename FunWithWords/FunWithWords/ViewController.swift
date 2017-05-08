//
//  ViewController.swift
//  FunWithWords
//
//  Created by Tom Holland on 5/7/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cluesLabel: UILabel!
    @IBOutlet var answersLabel: UILabel!
    @IBOutlet var currentAnswer: UITextField!
    @IBOutlet var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func submitTapped(_ sender: Any) {
    }
    @IBOutlet var clearTapped: UIButton!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

