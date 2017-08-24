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

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addCardView0: UIView!
    @IBOutlet weak var addCardView1: UIView!
    @IBOutlet weak var addCardView2: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func createStudySet(_ sender: Any) {
        let realm = try! Realm()
        
        let studySet = StudySet()
        studySet.title = titleTextField.text!
        studySet.createdAt = getTime()
        studySet.studySetID = "a-01"
        
        try! realm.write {
            realm.add(studySet)
        }
        
        print(realm.objects(StudySet.self))
    }
    
    
    func getTime() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        return formatter.string(from: date)
    }
    
    

}
