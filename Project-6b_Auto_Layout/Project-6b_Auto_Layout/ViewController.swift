//
//  ViewController.swift
//  Project-6b_Auto_Layout
//
//  Created by Marc Moxey on 4/15/23.
//
//
//  Try replacing the widthAnchor of our labels with leadingAnchor and trailingAnchor constraints, which more explicitly pin the label to the edges of its parent.
//
//  Once you’ve completed the first challenge, try using the safeAreaLayoutGuide for those constraints.
//    You can see if this is working by rotating to landscape, because the labels won’t go under the safe area.
//
//  Try making the height of your labels equal to 1/5th of the main view, minus 10 for the spacing.
//
//
//
//
//
//
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .systemRed
        label1.text = "THESE"
        label1.sizeToFit()
        
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .systemCyan
        label2.text = "ARE"
        label2.sizeToFit()
        
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .systemYellow
        label3.text = "SOME"
        label3.sizeToFit()
        
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .systemGreen
        label4.text = "AWESOME"
        label4.sizeToFit()
        
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .systemOrange
        label5.text = "LABELS"
        label5.sizeToFit()
        
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
//
//        let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5 ]
//
//        for label in viewsDictionary.keys {
//
//            view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|\(label)]|", options: [], metrics: nil, views: viewsDictionary))
//        }
//
//
//        view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[lable1]|-[lable12|-[lable3]|-[lable4]|-[lable5]", options: [], metrics: nil, views: viewsDictionary))
        
        var previous: UILabel?
        
        for label in [label1, label2, label3, label4, label5] {
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            label.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5, constant: -10).isActive = true 
            
            if let previous = previous {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            }
            
            previous = label
            
        }
    }
    


}

