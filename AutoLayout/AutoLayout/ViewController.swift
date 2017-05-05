//
//  ViewController.swift
//  AutoLayout
//
//  Created by Tom Holland on 5/5/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labelOne = UILabel()
        labelOne.translatesAutoresizingMaskIntoConstraints = false
        labelOne.backgroundColor = UIColor.red
        labelOne.text = " THESE"
        
        let labelTwo = UILabel()
        labelTwo.translatesAutoresizingMaskIntoConstraints = false
        labelTwo.backgroundColor = UIColor.cyan
        labelTwo.text = " ARE"
        
        let labelThree = UILabel()
        labelThree.translatesAutoresizingMaskIntoConstraints = false
        labelThree.backgroundColor = UIColor.yellow
        labelThree.text = " SOME"
        
        let labelFour = UILabel()
        labelFour.translatesAutoresizingMaskIntoConstraints = false
        labelFour.backgroundColor = UIColor.green
        labelFour.text = " AWESOME"
        
        let labelFive = UILabel()
        labelFive.translatesAutoresizingMaskIntoConstraints = false
        labelFive.backgroundColor = UIColor.orange
        labelFive.text = " LABELS"
        
        
        view.addSubview(labelOne)
        view.addSubview(labelTwo)
        view.addSubview(labelThree)
        view.addSubview(labelFour)
        view.addSubview(labelFive)
        
        let views = ["labelOne": labelTwo, "labelTwo": labelTwo,"labelThree": labelThree,"labelFour": labelFour,"labelFive": labelFive]
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

