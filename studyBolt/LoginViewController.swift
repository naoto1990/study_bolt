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
        print(loggedIn)
        
        if loggedIn {
            print("Logged in")
            self.performSegue(withIdentifier: "toTabBarController", sender: nil)
        } else {
            print("Not logged in")
        }
        
    }
    
    @IBAction func login(_ sender: UIButton) {
        LoginManager().logIn([.email], viewController: self, completion: {
            result in
            switch result {
            case let .success( permission, declinePemisson, token):
                print("token:\(token),\(permission),\(declinePemisson)")
            case let .failed(error):
                print("error:\(error)")
            case .cancelled:
                print("cancelled")
            }
            
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
//        loginButton.addTarget(self, action: "login", forControlEvents: UIControlEvents.TouchUpInside)
        
        view.addSubview(loginButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    }
    */

}
