//
//  ViewController.swift
//  WordGame
//
//  Created by Tom Holland on 5/4/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        populateWords()
        startGame()
    }
    
    func populateWords() {
        guard let path = Bundle.main.path(forResource: "words", ofType: "txt"),
            let words = try? String(contentsOfFile: path)
            else {
                allWords = ["silkworm"]
                return
        }
        
        allWords = words.components(separatedBy: "\n")
    }
    
    func startGame() {
        guard let allWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allWords) as? [String] else { return }
        
        title = allWords[0]
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

