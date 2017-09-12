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
    
    // カードの現在ポジションを表す値
    var cardIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(CreateSetViewController.textFieldDidChange(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        
        for i in cards {
            let card = Card()
            try! realm.write {
                card.term = i.term
                card.definition = i.definition
                card.studySetID = studySet.studySetID
                realm.add(card)
            }
            
        }
        
        navigationController?.popViewController(animated: true)
        
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
            if 0 >= cardIndex {
                lockScrollView()
            } else {
                lockScrollViewRight()
            }
        } else {
            if 0 >= cardIndex {
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
    
    
    func updateTextFields() {
        
        // カードスワイプ画面で2枚目以降にいる場合、直前の画面のUITextFieldに対応するカードデータを反映
        if cardIndex > 0 {
            createCardView0.termTextField.text = cards[cardIndex - 1].term
            createCardView0.definitionTextField.text = cards[cardIndex - 1].definition
            
        }
        
        // 現在画面のUITextFieldに対応するカードデータを反映
        createCardView1.termTextField.text = cards[cardIndex].term
        createCardView1.definitionTextField.text = cards[cardIndex].definition
        
        // 次の画面にカードデータが存在する場合、次の画面のUITextFieldに対応するカードデータを反映
        if cards.count > cardIndex + 1 {
            createCardView2.termTextField.text = cards[cardIndex + 1].term
            createCardView2.definitionTextField.text = cards[cardIndex + 1].definition
            
        } else {
            createCardView2.termTextField.text = nil
            createCardView2.definitionTextField.text = nil
            
        }
    }
}

extension CreateSetViewController: UITextFieldDelegate {
    
    // 各カードデータをcardsの配列に格納(UITextFieldに変更があるごとに更新)
    func textFieldDidChange(_ notification: Notification) {
        cards[cardIndex].term = createCardView1.termTextField.text
        cards[cardIndex].definition = createCardView1.definitionTextField.text
        
        updateLocking()
        
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
        print(cardIndex)

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
