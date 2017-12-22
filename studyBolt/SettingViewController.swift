//
//  SettingViewController.swift
//  studyBolt
//
//  Created by Naoto Ohno on 2017/10/10.
//  Copyright © 2017年 Naoto Ohno. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FBSDKCoreKit
import FBSDKLoginKit


var TableTitle = [ ["Account", "Logout"] ]

var TableSubtitle = [ ["", ""] ]


class SettingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.delegate = self
        loginButton.center = view.center
        view.addSubview(loginButton)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}


extension SettingViewController: LoginButtonDelegate {
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        print("######Logged in######")
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("######Logged out######")
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextView = storyboard.instantiateInitialViewController()
        present(nextView!, animated: true, completion: nil)
    }
}


extension SettingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // studySetCollectionの総数を返却
        return TableTitle[section].count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "settingCell")
        cell.textLabel?.text = TableTitle[indexPath.section][indexPath.row + 1]
        cell.detailTextLabel?.text = TableSubtitle[indexPath.section][indexPath.row + 1]
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TableTitle[section][0]
        
    }
    
    
}


extension SettingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Logout cell clicked")
        
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        print(FBSDKAccessToken.current())
        
        if FBSDKAccessToken.current() == nil {
            let storyboard: UIStoryboard = self.storyboard!
            let nextView = storyboard.instantiateViewController(withIdentifier: "loginView") as! LoginViewController
            self.present(nextView, animated: true, completion: nil)
        }
    }
}
