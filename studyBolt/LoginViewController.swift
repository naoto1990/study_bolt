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
        loginButton.center = view.center
        view.addSubview(loginButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    }

}
