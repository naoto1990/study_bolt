//
//  LoginViewController.swift
//  studyBolt
//
//  Created by Naoto Ohno on 2017/10/05.
//  Copyright © 2017年 Naoto Ohno. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    @IBAction func isLoggedInWithFB(_ sender: Any) {
        let loggedIn = AccessToken.current != nil
        if loggedIn {
            print("Logged in")
        } else {
            print("Not logged in")
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.delegate = self
        loginButton.center = view.center
        view.addSubview(loginButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    }

}
extension LoginViewController: LoginButtonDelegate {
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        print("######Logged in######")
        self.performSegue(withIdentifier: "toTabBarController", sender: nil)
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("######Logged out######")
    }
}
