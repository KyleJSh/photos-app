//
//  UserService.swift
//  PhotosApp
//
//  Created by Kyle Sherrington on 2021-03-12.
//

import Foundation
import FirebaseFirestore

class UserService {
    
    static func createProfile(userId:String, username:String, completion: @escaping (PhotoUser?) -> Void ) {
        
        // Create a dictionary for the profile data
        let profileData = ["username":username]
        
        // Get a firestore reference
        let db = Firestore.firestore()
        
        // Create the document for the userId
        db.collection("users").document(userId).setData(profileData) { (error) in
            
            // Check for errors
            if error == nil {
                // Profile was created successfully
                // Create and return a photo user
                var u = PhotoUser()
                u.username = username
                u.userId = userId
                
                completion(u)
            }
            else {
                // Something went wrong
                // Return nil
                completion(nil)
            }
        }
    }
    
    static func retrieveProfile(userId:String, completion: @escaping (PhotoUser?) -> Void ) {
        
        // Get a firestore reference
        let db = Firestore.firestore()
        
        
        // Check for a profile, given the userID
        db.collection("users").document(userId).getDocument { (snapshot, error) in
            
            // check for errors
            if error != nil || snapshot == nil {
                
                // something wrong happened
                return
            }
            
            if let profile = snapshot!.data() {
                // profile was found, create a new Photo user
                
                var u = PhotoUser()
                u.userId = snapshot!.documentID
                u.username = profile["username"] as? String
                
                // Return the user
                completion(u)
            }
            else {
                // Couldn't get profile, no profile
                // Return nil
                completion(nil)
            }
        }
    }
}
