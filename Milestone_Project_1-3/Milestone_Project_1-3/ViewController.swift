//
//  ViewController.swift
//  Milestone_Project_1-3
//
//  Created by Marc Moxey on 4/12/23.
//
//
//  Start with a Single View App template, then change its main ViewController class so that builds on UITableViewController instead.
//
//  Load the list of available flags from the app bundle. You can type them directly into the code if you want, but it’s preferable not to.
//
//  Create a new Cocoa Touch Class responsible for the detail view controller, and give it properties for its image view and the image to load.
//
//  You’ll also need to adjust your storyboard to include the detail view controller, including using Auto Layout to pin its image view correctly.
//
//  You will need to use UIActivityViewController to share your flag.
//
//   challenge is to create an app that lists various world flags in a table view.
//
//  When one of them is tapped, slide in a detail view controller that contains an image view, showing the same flag full size.
//   On the detail view controller, add an action button that lets the user share the flag picture and country name using UIActivityViewController.
//
//
//
//
import UIKit

class ViewController: UITableViewController {
    
    var flags = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        // load list of available flags
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix("png") {
                flags.append(item)
            }
        }
        title = "MilesStone Project 1 - 3"
        //navigationController?.navigationBar.prefersLargeTitles = true 
       // print(flags)
    }
    
 // return cell number of cells
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    // create the cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  "Flag", for: indexPath)
        cell.textLabel?.text = flags[indexPath.row]
        return cell
    }
    
    // shows the flag that was selected in new screen(DetailVC)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // go to detailVC
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailVC {
            
            // selected image
            detailVC.selectedImage = flags[indexPath.row]
            
            // show VC
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
   
}

