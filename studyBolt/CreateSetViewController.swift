//
//  CreateSetViewController.swift
//  studyBolt
//
//  Created by Naoto Ohno on 2017/08/24.
//  Copyright © 2017年 Naoto Ohno. All rights reserved.
//

import UIKit
import RealmSwift

class CreateSetViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var createCardView0: CreateCardView!
    @IBOutlet var createCardView1: CreateCardView!
    @IBOutlet var createCardView2: CreateCardView!

    
    var cards = [Card()]
    var cardIndex = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(CreateSetViewController.textFieldDidChange(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        populateDemoCards(num: 6)
        updateTextFields()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateLocking()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        moveToCenter()
    }
    
    @IBAction func createStudySet(_ sender: Any) {
        let realm = try! Realm()
        
        let studySet = StudySet()
        studySet.title = titleTextField.text!
        studySet.createdAt = getTime()
        studySet.studySetID = generateStudySetID()
        try! realm.write {
            realm.add(studySet)
        }
        
        let card = Card()
        for c in cards {
            card.term = c.term
            card.definition = c.definition
            card.studySetID = studySet.studySetID
            
            try! realm.write {
                realm.add(card)
            }
            
        }
        
    }

    func getTime() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        return formatter.string(from: date)
    }
    
    func generateStudySetID() -> String {
        let uuid = NSUUID().uuidString
        
        return uuid
    }
    
    

}


extension CreateSetViewController {
    
    func updateLocking() {
        if createCardView1.termTextField.text!.isEmpty && createCardView1.definitionTextField.text!.isEmpty {
            if cardIndex <= 0 {
                lockScrollView()
            } else {
                lockScrollViewRight()
            }
        } else {
            if cardIndex <= 0 {
                lockScrollViewLeft()
            } else {
                unlockScrollView()
            }
        }
    }
    
    func lockScrollView() {
        let insets = UIEdgeInsets(top: 0, left: -scrollView.frame.size.width, bottom: 0, right: -scrollView.frame.size.width)
        scrollView.contentInset = insets
    }
    
    func lockScrollViewRight() {
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -scrollView.frame.size.width)
        scrollView.contentInset = insets
    }
    
    func lockScrollViewLeft() {
        let insets = UIEdgeInsets(top: 0, left: -scrollView.frame.size.width, bottom: 0, right: 0)
        scrollView.contentInset = insets
    }
    
    func unlockScrollView() {
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    func moveToCenter() {
        scrollView.contentOffset = CGPoint(x: scrollView.frame.size.width, y: 0)
    }
    
    //  カードが2枚以上存在する際に、手前のカードのデータを反映する
    func updateTextFields() {
        
        // Also needs to update text field content
        if cardIndex > 0 {
            createCardView0.termTextField.text = cards[cardIndex - 1].term
            createCardView0.definitionTextField.text = cards[cardIndex - 1].definition
            print(cardIndex)
        }
        
        createCardView1.termTextField.text = cards[cardIndex].term
        createCardView1.definitionTextField.text = cards[cardIndex].definition
        
        // カードの末尾から2つ目になるまで、末尾のカードのデータを反映する
        if cardIndex + 1 < cards.count {
            createCardView2.termTextField.text = cards[cardIndex + 1].term
            createCardView2.definitionTextField.text = cards[cardIndex + 1].definition
            print(cardIndex)
            
        } else {
            createCardView2.termTextField.text = nil
            createCardView2.definitionTextField.text = nil
            print(cardIndex)
        }
    }
}

extension CreateSetViewController: UITextFieldDelegate {
    
    // 各カードデータをcardIndex毎にcardsの配列に格納
    func textFieldDidChange(_ notification: Notification) {
        let currentCard = cards[cardIndex]
        currentCard.term = createCardView1.termTextField.text
        currentCard.definition = createCardView1.definitionTextField.text
        
        updateLocking()
        
        print("text field got chnaged")
    }
    
}

extension CreateSetViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        if offset.x != scrollView.frame.size.width {
            if offset.x == 0 {
                cardIndex -= 1
            } else {
                cardIndex += 1
            }
            moveToCenter()
            
            
            
            if cardIndex >= cards.count {
                cards.append(Card())
            }
            
            updateTextFields()
            
            // Need to update locking
            updateLocking()
        }

    }
}

// テスト用メソッド
extension CreateSetViewController {
    
    // テスト用のデモカードデータを返すメソッド
    func populateDemoCards(num: Int) {
        
        for i in 0...num {
            let demoCard = Card()
            demoCard.studySetID = "a" + String(i)
            demoCard.term = "aaa" + String(i)
            demoCard.definition = "bbb" + String(i)
            
            cards.append(demoCard)
        }
        
    }
}
