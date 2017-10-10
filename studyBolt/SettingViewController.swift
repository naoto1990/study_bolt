//
//  SettingViewController.swift
//  studyBolt
//
//  Created by Naoto Ohno on 2017/10/10.
//  Copyright © 2017年 Naoto Ohno. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class SettingViewController: UIViewController {
    @IBAction func logout(_ sender: Any) {
        let loginManager : FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextView = storyboard.instantiateInitialViewController()
        present(nextView!, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
