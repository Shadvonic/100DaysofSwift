//
//  ViewController.swift
//  Project-1_Storm_Viewer
//
//  Created by Marc Moxey on 4/11/23.
//
/* Challenge
For this project, your challenges are:

Use Interface Builder to select the text label inside your table view cell and adjust its font size to something larger – experiment and see what looks good.
 
In your main table view, show the image names in sorted order, so “nssl0033.jpg” comes before “nssl0034.jpg”.
 
Rather than show image names in the detail title bar, show “Picture X of Y”, where Y is the total number of images and X is the selected picture’s position in the array. Make sure you count from 1 rather than 0.
*/
//
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true 
        
        // set file Manager
        let fm = FileManager.default
        
        // set path for app bundle
        let path = Bundle.main.resourcePath!
        
        // collection of all the files found in the directory
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        // loop the array with prefix 'nssl'
        for item in items {
            if item.hasPrefix("nssl") {
                // load picture and append to pictures array
                pictures.append(item)
            
            }
        }
       //print(pictures)
    }
    
    

    // how many rows should be shown
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pictures.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // recycle cells in tableview
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        // cell get the same name as picture name
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // load DetailVC
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailVC {
            // set the selected image property
            detailVC.selectedImage = pictures[indexPath.row]
            // show the new VC
            navigationController?.pushViewController(detailVC, animated: true)
        }
    
    }

}

