//
//  ViewController.swift
//  Project-5_Word_Scramble
//
//  Created by Marc Moxey on 4/13/23.
//
//  Challenge
//
//  Disallow answers that are shorter than three letters or are just our start word. For the three-letter check,
//  the easiest thing to do is put a check into isReal() that returns false if the word length is under three letters.
//  For the second part, just compare the start word against their input word and return false if they are the same.
//
//  Refactor all the else statements we just added so that they call a new method called showErrorMessage().
//  This should accept an error message and a title, and do all the UIAlertController work from there.
//
//  Add a left bar button item that calls startGame(), so users can restart with a new word whenever they want to.
//
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWord = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New Game", style: .plain, target: self, action: #selector(startGame))
        // find the path to flie
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // load contents
            if let startWords = try? String(contentsOf: startWordsURL) {
                // split into an array
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        // check if array is empety
        if allWords.isEmpty {
            // if it empty give default value
            allWords = ["silkworm"]
        }
        
        startGame()
     
       
    }
    
    @objc func startGame() {
        // random word in array
        title = allWords.randomElement()
        // remove all words from used words array
        usedWord.removeAll(keepingCapacity: true)
        // reload rows and section
        tableView.reloadData()
    }
    
    @objc func  promptForAnswer() {
        
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            // input into the clousre (must use weak)
            [weak self, weak ac] action in
            // read first textfield, safely check textbook and submit button there
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
            
            
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    func submit(_ answer: String) {
        
        let lowerAnswer = answer.lowercased()
        // check if you can make a word from given word
        if isPossible(word: lowerAnswer) {
            // check if vaild word
            if isOriginal(word: lowerAnswer) {
                // check if it been used already
                if isReal(word: lowerAnswer) {
                    // submit to word to usedWords array
                    usedWord.insert(answer, at: 0)
                    
                    // create a new row into top of the tableview
                    let indexPath = IndexPath(row: 0, section:  0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    
                    return
                } else {
                    showErrorMessage("Word not recognized", "You can't just make them up, you know")
                }
            } else {
                showErrorMessage("World Already used", "Be more original!")
            }
        } else {
            showErrorMessage("Word not possible", "You can't spell that word from \(title!.lowercased())).")
        }
    }
    
    
    func isPossible(word: String) -> Bool {
        // check for title in table view
        guard var tempWord = title?.lowercased() else { return false }
        
        // loop over all letter
        for letter in word {
            // look for first time letter it appeared
            if let position = tempWord.firstIndex(of: letter) {
                // remove the letter for tempWord so can't used the same letter twice
                tempWord.remove(at: position)
                
            } else {
                return false
            }
                
        }
        
        return true
    }
    
    func isOriginal(word: String) -> Bool {
     // if it contains word return true
        return !usedWord.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        var tempWord = title?.lowercased()
        if word.count < 3 || word == tempWord {
            return false
        }
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    
    func showErrorMessage(_ errorTitle: String, _ errorMessage: String) {
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        usedWord.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWord[indexPath.row]
        return cell
    }

}

