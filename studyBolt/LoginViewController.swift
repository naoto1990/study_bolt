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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        let newCenter = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height - 180)
        loginButton.center = newCenter
        view.addSubview(loginButton)
        
        loginButton.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 既にログイン済みの場合は、Home画面へ遷移
        if FBSDKAccessToken.current() !== nil {
            let storyboard: UIStoryboard = self.storyboard!
            let nextView = storyboard.instantiateViewController(withIdentifier: "tabBarView") as! UITabBarController
            self.present(nextView, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func isLoggedInWithFacebook() -> Bool {
        let loggedIn = AccessToken.current != nil
        
        return loggedIn
    }

}


extension LoginViewController: LoginButtonDelegate {
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        print("######Logged in######")
        OperationQueue.main.addOperation {
            [weak self] in
            let storyboard: UIStoryboard = self!.storyboard!
            let nextView = storyboard.instantiateViewController(withIdentifier: "tabBarView")
            self?.present(nextView, animated: true, completion: nil)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("######Logged out######")
    }
}
