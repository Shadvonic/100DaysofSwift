//
//  ViewController.swift
//  Project-5_Word_Scramble
//
//  Created by Marc Moxey on 4/13/23.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWord = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
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
    
    func startGame() {
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
        let errorTitle: String
        let errorMessage: String
        
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
                    errorTitle = "Word not recognized"
                    errorMessage = "You can't just make them up, you know"
                }
            } else {
                errorTitle = "World Already used"
                errorMessage = "Be more original!"
            }
        } else {
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from \(title!.lowercased()))."
        }
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
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
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
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

