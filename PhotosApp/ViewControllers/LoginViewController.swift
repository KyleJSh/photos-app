//
//  LoginViewController.swift
//  PhotosApp
//
//  Created by Kyle Sherrington on 2021-03-12.
//

import UIKit
import FirebaseUI

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create smooth corners on loginButton
        loginButton.layer.cornerRadius = 10
        
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // create a Firebase AuthUI obj
        let authUI = FUIAuth.defaultAuthUI()
        
        // check it isn't nil
        if let authUI = authUI {
            
            // set self as delegate for authUI
            authUI.delegate = self
            
            // set sign in providers
            authUI.providers = [FUIEmailAuth()]
            
            // get the prebuilt UI ViewController
            let authViewController = authUI.authViewController()
            
            // present it
            present(authViewController, animated: true, completion: nil)
        }
    }
}

extension LoginViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        if error != nil {
            // there was an error
            return
        }
        
        let user = authDataResult?.user
        
        if let user = user {
            
            // got a user
            // check on the database side if user has a profile
            UserService.retrieveProfile(userId: user.uid) { (user) in
                
                // check if user is nil
                if user == nil {
                    // If not, go to create profile view controller
                    self.performSegue(withIdentifier: Constants.Storyboard.profileSegue, sender: self)
                }
                else {
                    // If so, go to tab bar controller
                    
                    // Save user to local storage
                    LocalStorageService.saveUser(userId: user!.userId, username: user!.username)
                    
                    // Create an instance of the tab bar controller
                    let tabBarVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabBarController)
                    
                    guard tabBarVC != nil else {
                        return
                    }
                    
                    // Set it as the root view controller of the window
                    self.view.window?.rootViewController = tabBarVC
                    self.view.window?.makeKeyAndVisible()
                }
            }
        }
    }
}
