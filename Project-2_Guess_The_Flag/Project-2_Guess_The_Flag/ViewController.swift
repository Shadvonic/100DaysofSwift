//
//  ViewController.swift
//  Project-2_Guess_The_Flag
//
//  Created by Marc Moxey on 4/12/23.
//
//Challenge
//
// Try showing the player’s score in the navigation bar, alongside the flag to guess.
//
// Keep track of how many questions have been asked, and show one final alert controller after they have answered 10. This should show their final score.
//
// When someone chooses the wrong flag, tell them their mistake in your alert message – something like “Wrong! That’s the flag of France,” for example.
//
//
import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // append to countries array
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "usa"]
        
        // set border width
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        // set borader color to lightGray; covert to cgColor
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
       
        
        askQuestion()
        
    }

    
    // method that shows 3 random images
    func askQuestion(action: UIAlertAction! = nil) {
        
        // shuffle countries array
        countries.shuffle()
        // just random flag from first 3 items in array after in been shuffled
        correctAnswer = Int.random(in: 0...2)
        
        // set button image
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        // assign the title the name of the correct answer and uppcarse the whole word
        title = countries[correctAnswer].uppercased()
    }

    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var title: String
        
        // check if answer correct
        if sender.tag == correctAnswer {
            title = "Correct"
            // ajust player score
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        
        // show message what new score is
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Contiune", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
    
}

