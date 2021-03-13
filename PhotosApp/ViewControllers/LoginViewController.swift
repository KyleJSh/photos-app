//
//  LoginViewController.swift
//  PhotosApp
//
//  Created by Kyle Sherrington on 2021-03-12.
//

import UIKit
import FirebaseUI


class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    @IBAction func loginTapped(_ sender: Any) {
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
            
            // if not, go to create profile view controller
            
            // if so, go to tab bar controller
            
        }
        
    }
}
