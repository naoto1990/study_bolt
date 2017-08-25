//
//  CreateSetViewController.swift
//  studyBolt
//
//  Created by Naoto Ohno on 2017/08/24.
//  Copyright © 2017年 Naoto Ohno. All rights reserved.
//

import UIKit
import RealmSwift

class CreateSetViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var createCardView0: CreateCardView!
    @IBOutlet var createCardView1: CreateCardView!
    @IBOutlet var createCardView2: CreateCardView!

    
    var cards = [Card()]
    var cardIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        updateLocking()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }

    func textFieldDidChange(_ notification: Notification) {
        let currentCard = cards[cardIndex]
//        currentCard.term = addCardView1.term.text
//        currentCard.definition = addCardView1.definitionTextField.text
        
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


extension CreateSetViewController {
    
//    func updateLocking() {
//        if addCardView1.termTextField.text!.isEmpty && addCardView1.definitionTextField.text!.isEmpty {
//            if cardIndex <= 0 {
//                lockScrollView()
//            } else {
//                lockScrollViewRight()
//            }
//        } else {
//            if cardIndex <= 0 {
//                lockScrollViewLeft()
//            } else {
//                unlockScrollView()
//            }
//        }
//    }
//    
//    func lockScrollView() {
//        let insets = UIEdgeInsets(top: 0, left: -scrollView.frame.size.width, bottom: 0, right: -scrollView.frame.size.width)
//        scrollView.contentInset = insets
//    }
//    
//    func lockScrollViewRight() {
//        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -scrollView.frame.size.width)
//        scrollView.contentInset = insets
//    }
//    
//    func lockScrollViewLeft() {
//        let insets = UIEdgeInsets(top: 0, left: -scrollView.frame.size.width, bottom: 0, right: 0)
//        scrollView.contentInset = insets
//    }
//    
//    func unlockScrollView() {
//        scrollView.contentInset = UIEdgeInsets.zero
//    }
//    
//    func moveToCenter() {
//        scrollView.contentOffset = CGPoint(x: scrollView.frame.size.width, y: 0)
//    }
    
}
