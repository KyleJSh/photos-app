//
//  CreateProfileViewController.swift
//  PhotosApp
//
//  Created by Kyle Sherrington on 2021-03-12.
//

import UIKit
import FirebaseAuth

class CreateProfileViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirmTapped(_ sender: Any) {
        
        // Check that there is a user logged in
        guard Auth.auth().currentUser != nil else {
            // No user logged in
            return
        }
        
        // Get the username
        // Check against whitespaces, new lines, illegal characters, etc.
        let username = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Check that the username isn't nil
        if username == nil || username == "" {
            // Show an error message
            return
        }
        
        // Call the user service to the profile
        UserService.createProfile(userId: Auth.auth().currentUser!.uid, username: username!) { (user) in
            
            // Check if it was successfully created
            if user != nil {
                // If so, go to the tab bar controller
                
                // Save user to local storage
                LocalStorageService.saveUser(userId: user!.userId, username: user!.username)
                
                let tabBarVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabBarController)
                
                self.view.window?.rootViewController = tabBarVC
                self.view.window?.makeKeyAndVisible()
            }
            else {
                // If not, display error
            }
        }
    }
}
