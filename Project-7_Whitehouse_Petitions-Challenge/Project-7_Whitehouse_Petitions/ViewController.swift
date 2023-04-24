//
//  ViewController.swift
//  Project-7_Whitehouse_Petitions
//
//  Created by Marc Moxey on 4/16/23.
//
//
//
// Challenge
//
// Add a Credits button to the top-right corner using UIBarButtonItem.
//  When this is tapped, show an alert telling users the data comes from the We The People API of the Whitehouse.
//
//  Let users filter the petitions they see. This involves creating a second array of filtered items that contains only petitions matching a string the user entered.
//  Use a UIAlertController with a text field to let them enter that string.
//
//
//
//
// Modify project 7 so that your filtering code takes place in the background.
// This filtering code was added in one of the challenges for the project,
//
//
//
//
//
import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let urlString: String
        
        // "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        
        
        // convert  string to a url
        if let url = URL(string: urlString) {
            // convert url to data instance
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        showError()
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed. Please check your connetction and try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style:  .default))
        present(ac, animated: true)
    }
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
       return petitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailVC()
        detailVC.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

