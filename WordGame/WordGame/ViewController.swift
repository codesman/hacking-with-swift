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
    
    private func setupNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
    }
    
    private func populateWords() {
        let defaultWords = ["silkworm"]
        
        guard let path = Bundle.main.path(forResource: "words", ofType: "txt") else {
            allWords = defaultWords
            return
        }
        
        guard let words = try? String(contentsOfFile: path) else {
            allWords = defaultWords
            return
        }
        
        allWords = words.components(separatedBy: "\n")
    }
    
    private func startGame() {
        guard let allWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allWords) as? [String] else { return }
        
        title = allWords[0]
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc private func promptForAnswer() {
        let alert = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned self, alert] _ in
            guard let answerField = alert.textFields?[0] else { return }
            guard let answer = answerField.text else { return }
            answerField.autocorrectionType = .no
            
            self.submit(answer)
        }
        
        alert.addAction(submitAction)
        present(alert, animated: true)
    }
    
    private func submit(_ answer: String) {
        guard answer.characters.count > 2 else {
            showErrorAlert(title: Word.tooShort.title, message: Word.tooShort.message)
            return
        }
        
        guard let titleLowercased = title?.lowercased(), answer != titleLowercased else {
            showErrorAlert(title: Word.isStartWord.title, message: Word.isStartWord.message)
            return
        }
        
        let answerLowercased = answer.lowercased()
        
        if wordNotUsed(from: answerLowercased)
            && wordIsPossible(from: answerLowercased)
            && wordIsReal(from: answerLowercased){
            usedWords.insert(answer, at: 0)
            
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        } else {
            // TODO: Refactor with switch
            if !wordNotUsed(from: answerLowercased) {
                showErrorAlert(title: Word.wasUsed.title, message: Word.wasUsed.message)
                
            } else if !wordIsPossible(from: answerLowercased) {
                showErrorAlert(title: Word.notPossible(answerLowercased).title, message: Word.notPossible(answerLowercased).message)
                
            } else if !wordIsReal(from: answerLowercased){
                showErrorAlert(title: Word.notReal.title, message: Word.notReal.message)
            }
        }
    }
    
    private func wordNotUsed(from word: String) -> Bool {
        
        return !usedWords.contains(word)
    }

    private func wordIsPossible(from word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for character in word.characters {
            guard let possible = tempWord.range(of: String(character)) else { return false }
            
            tempWord.remove(at: possible.lowerBound)
        }
        
        return true
    }
    
    private func wordIsReal(from word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSMakeRange(0, word.utf16.count)
        let misspelled = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelled.location == NSNotFound
    }
    
    private func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true)
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

