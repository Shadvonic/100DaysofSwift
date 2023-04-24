//
//  ViewController.swift
//  Project-4_Easy_Browser
//
//  Created by Marc Moxey on 4/13/23.
//
//  If users try to visit a URL that isn’t allowed, show an alert saying it’s blocked.
//
//  Try making two new toolbar items with the titles Back and Forward.
//  You should make them use webView.goBack and webView.goForward.
//
//  For more of a challenge, try changing the initial view controller to a table view like in project 1,
//  where users can choose their website from a list rather than just having the first in the array loaded up front
//
//
//
//
import UIKit


class ViewController: UITableViewController {
  

   var websites = ["mangafire.to", "9anime.to", "onepiecechapters.com"]


    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailVC {
            detailVC.selectedWebsite = websites[indexPath.row]
            navigationController?.pushViewController(detailVC, animated: true)
        }
            
    }
  
}

