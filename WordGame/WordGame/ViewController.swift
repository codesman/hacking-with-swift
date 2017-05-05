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
        
        setupNavigation()
        populateWords()
        startGame()
    }
    
    func setupNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
    }
    
    func promptForAnswer() {
        let alert = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned self, alert] _ in
            guard let answerField = alert.textFields?[0] else { return }
            guard let answer = answerField.text else { return }
            
            self.submit(answer)
        }
        
        alert.addAction(submitAction)
        present(alert, animated: true)
    }
    
    func submit(_ answer: String) {
        let answerLowercased = answer.lowercased()
        
        if wordIsPossible(from: answerLowercased)
            && wordIsOriginal(from: answerLowercased)
            && wordIsReal(from: answerLowercased){
            usedWords.insert(answer, at: 0)
            
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    func wordIsPossible(from word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for character in word.characters {
            guard let possible = tempWord.range(of: String(character)) else { return false }
            
            tempWord.remove(at: possible.lowerBound)
        }
        
        return true
    }
    
    func wordIsOriginal(from word: String) -> Bool {
        
        return !usedWords.contains(word)
    }
    
    func wordIsReal(from word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSMakeRange(0, word.utf16.count)
        let misspelled = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelled.location == NSNotFound
    }
    
    func populateWords() {
        guard let path = Bundle.main.path(forResource: "words", ofType: "txt") else { return }
        guard let words = try? String(contentsOfFile: path) else {
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        
        cell.textLabel?.text = usedWords[indexPath.row]
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

