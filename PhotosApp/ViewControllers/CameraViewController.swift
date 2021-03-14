//
//  CameraViewController.swift
//  PhotosApp
//
//  Created by Kyle Sherrington on 2021-03-12.
//

import UIKit

class CameraViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func savePhoto(image:UIImage) {
        
        // Call the photo service to store the photo
        PhotoService.savePhoto(image: image)
        
    }

}
