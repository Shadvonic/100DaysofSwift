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
    
    var selectedPictureNmber = 0
    var totalPictures = 0 
    
    // hold the name for the image to load
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // display name of select picture; Picture  X of Y (total picture)
        title =  "Picture \(selectedPictureNmber) of \(totalPictures)"
        
        
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
