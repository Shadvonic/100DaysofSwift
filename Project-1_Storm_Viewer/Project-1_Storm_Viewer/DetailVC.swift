//
//  DetailVC.swift
//  Project-1_Storm_Viewer
//
//  Created by Marc Moxey on 4/11/23.
//

import UIKit

class DetailVC: UIViewController {

    // contection from something in interface builder
    @IBOutlet var imageView: UIImageView!
    
    // hold the name for the image to load
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // display name of selecte picture
        title = selectedImage
        // never use large title 
        navigationItem.largeTitleDisplayMode = .never

        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false

    }
    



}
