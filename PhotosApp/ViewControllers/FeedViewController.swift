//
//  FeedViewController.swift
//  PhotosApp
//
//  Created by Kyle Sherrington on 2021-03-12.
//

import UIKit

class FeedViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Call the photo service to retrieve the photos
        PhotoService.retrievePhotos { (retrievedPhotos) in
            
            // Set our photos array to the retrieved photos
            self.photos = retrievedPhotos
            
            // Tell the table view to reload
            self.tableView.reloadData()
            
        }
    }
    

}
