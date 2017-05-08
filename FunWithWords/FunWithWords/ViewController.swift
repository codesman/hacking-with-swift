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
    
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    var score = 0
    var level = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupButtons()
        
    }
    
    func setupButtons(){
        for subview in view.subviews where subview.tag == 1001 {
            guard let btn = subview as? UIButton else { return }
            
            letterButtons.append(btn)
            btn.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
        }
    }
    
    func letterTapped(){
        
    }
    @IBAction func clearTapped(_ sender: Any) {
    }
    
    @IBAction func submitTapped(_ sender: Any) {
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

