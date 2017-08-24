//
//  CreateSetViewController.swift
//  studyBolt
//
//  Created by Naoto Ohno on 2017/08/24.
//  Copyright © 2017年 Naoto Ohno. All rights reserved.
//

import UIKit
import RealmSwift

class CreateSetViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var demoTitle: UITextField!
    @IBOutlet weak var demoTerm: UITextField!
    @IBOutlet weak var demoDefinition: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        demoTitle.delegate = self
        demoTerm.delegate = self
        demoDefinition.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func createDemoSet(_ sender: Any) {
        let realm = try! Realm()
        
        let studySet = StudySet()
        studySet.title = demoTitle.text!
        studySet.createdAt = "08242017"
        studySet.studySetID = "a-01"
        
        try! realm.write {
            realm.add(studySet)
        }
        
        print(realm.objects(StudySet.self))
        
    }
    
    

}
