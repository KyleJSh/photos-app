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

        // Set view controller as the datasource and delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        // Add pull to refresh
        addRefreshControll()
        
        // Call the photo service to retrieve the photos
        PhotoService.retrievePhotos { (retrievedPhotos) in
            
            // Set our photos array to the retrieved photos
            self.photos = retrievedPhotos
            
            // Tell the table view to reload
            self.tableView.reloadData()
            
        }
    }
    
    func addRefreshControll() {
        
        // Create refresh control
        let refresh = UIRefreshControl()
        
        // Set target
        refresh.addTarget(self, action: #selector(refreshFeed(refreshControl:)), for: .valueChanged)
        
        // Add to table view
        self.tableView.addSubview(refresh)
        
    }
    
    @objc func refreshFeed(refreshControl: UIRefreshControl) {
        
        // Call the photo service
        PhotoService.retrievePhotos { (newPhotos) in
            
            // Assign new photos to our photos property
            self.photos = newPhotos
            
            DispatchQueue.main.async {
                
                // Refresh table view
                self.tableView.reloadData()
                
                // Stop the spinner
                refreshControl.endRefreshing()
            }
            
        }
    }

}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return photos.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a Photo Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.photoCellId, for: indexPath) as? PhotoCell
        
        // Get the photo this cell is displaying
        let photo = self.photos[indexPath.row]
        
        // Call display photo method of the cell
        cell?.displayPhoto(photo: photo)
        
        // Return the cell
        return cell!
    }
    
  
}
