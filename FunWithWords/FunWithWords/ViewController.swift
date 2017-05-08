//
//  ViewController.swift
//  FunWithWords
//
//  Created by Tom Holland on 5/7/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import UIKit
import GameplayKit

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
        loadLevel()
    }
    
    func setupButtons(){
        for subview in view.subviews where subview.tag == 1001 {
            guard let btn = subview as? UIButton else { return }
            
            letterButtons.append(btn)
            btn.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
        }
    }
    
    func loadLevel() {
        guard let path = Bundle.main.path(forResource: "level\(level)", ofType: "txt") else { return }
        guard let levelContents = try? String(contentsOfFile: path) else { return }
        let lines = levelContents.components(separatedBy: "\n")
        
        guard let shuffledLines = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: lines) as? [String] else { return }
        
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        for (index, line) in shuffledLines.enumerated() {
            let parts = line.components(separatedBy: ": ")
            let answer = parts[0]
            let clue = parts[1]
            
            clueString += "\(index + 1), \(clue)\n"
            
            let solutionWord = answer.replacingOccurrences(of: "|", with: "")
            solutionString += "\(solutionWord.characters.count) letters\n"
            solutions.append(solutionWord)
            
            let bits = answer.components(separatedBy: "|")
            letterBits += bits
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

