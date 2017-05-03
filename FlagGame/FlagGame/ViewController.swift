//
//  ViewController.swift
//  FlagGame
//
//  Created by Tom Holland on 5/3/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    @IBOutlet var buttonOne: UIButton!
    @IBOutlet var buttonTwo: UIButton!
    @IBOutlet var buttonThree: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += [
            "estonia",
            "france",
            "germany",
            "ireland",
            "italy",
            "monaco",
            "nigeria",
            "poland",
            "russia",
            "spain",
            "uk",
            "us"
        ]
        
        buttonOne.layer.borderWidth = 1
        buttonTwo.layer.borderWidth = 1
        buttonThree.layer.borderWidth = 1
        
        buttonOne.layer.borderColor = UIColor.lightGray.cgColor
        buttonTwo.layer.borderColor = UIColor.lightGray.cgColor
        buttonThree.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func askQuestion(action: UIAlertAction! = nil) {
        countries = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: countries) as! [String]
        
        buttonOne.setImage(UIImage(named: countries[0]), for: .normal)
        buttonTwo.setImage(UIImage(named: countries[1]), for: .normal)
        buttonThree.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = GKRandomSource.sharedRandom().nextInt(upperBound: 3)
        
        title = countries[correctAnswer].uppercased()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        
        let scoreMessage = "Your score is \(score)"
        let alert = UIAlertController(title: title, message: scoreMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(alert, animated: true)
        
    }
}

