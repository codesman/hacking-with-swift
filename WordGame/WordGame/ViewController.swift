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
        
        // TODO: Disallow entering start word
        if wordNotUsed(from: answerLowercased)
            && wordIsPossible(from: answerLowercased)
            && wordIsReal(from: answerLowercased){
            usedWords.insert(answer, at: 0)
            
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        } else {
            // TODO: Refactor with switch
            if !wordNotUsed(from: answerLowercased) {
                showErrorAlert(title: "Word used already", message: "Be more original!")
                
            } else if !wordIsPossible(from: answerLowercased) {
                if let titleLowercased = title?.lowercased() {
                    showErrorAlert(title: "Word not possible", message: "You can't spell that word from \(titleLowercased)")
                }
            } else if !wordIsReal(from: answerLowercased){
                showErrorAlert(title: "Word not recognized", message: "You can't just make them up, you know!")
            }
        }
    }
    
    func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true)
    }
    
    func wordIsPossible(from word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for character in word.characters {
            guard let possible = tempWord.range(of: String(character)) else { return false }
            
            tempWord.remove(at: possible.lowerBound)
        }
        
        return true
    }
    
    func wordNotUsed(from word: String) -> Bool {
        
        return !usedWords.contains(word)
    }
    
    func wordIsReal(from word: String) -> Bool {
        // TODO: Check answer < 3 letters
        
        let checker = UITextChecker()
        let range = NSMakeRange(0, word.utf16.count)
        let misspelled = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelled.location == NSNotFound
    }
    
    func populateWords() {
        // TODO: Handle no path case
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

