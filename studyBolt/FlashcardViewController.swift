//
//  FlashcardViewController.swift
//  studyBolt
//
//  Created by Naoto Ohno on 2017/09/08.
//  Copyright © 2017年 Naoto Ohno. All rights reserved.
//

import UIKit
import RealmSwift

class FlashcardViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    // 現状使用していない
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var centerScrollView: UIScrollView!
    // 現状使用していない
    @IBOutlet weak var centerContainerView: UIView!
    
    @IBOutlet weak var flashcardView0: FlashcardView!
    @IBOutlet weak var flashcardView1: FlashcardView!
    @IBOutlet weak var flashcardView2: FlashcardView!
    @IBOutlet weak var flashcardViewL: FlashcardView!
    @IBOutlet weak var flashcardViewR: FlashcardView!
    
    
    
    var cards: Results<Card>!
    
    // カードの現在ポジションを表す値
    var cardIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        let termString = cards[cardIndex].term
        flashcardView1.termInFlashCard.text = termString
        
        let definitionString = cards[cardIndex].definition
        flashcardViewL.definitionInFlashCard.text = definitionString
        flashcardViewR.definitionInFlashCard.text = definitionString
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // TODO: 下記必要あるか確認。必要なければ全箇所から削除
        super.viewWillAppear(animated)
        
        updateLabels()
        updateLabelsInLeftAndRight()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        moveToCenter()
        updateLocking()
    }

}


extension FlashcardViewController {
    
    func updateLocking() {
        unlockScrollView()
        if cardIndex <= 0 {
            lockScrollViewTop()
            
            if cards.count == 1{
                lockScrollView()
            }
        }
        else{
            if cardIndex + 1 >= cards.count{
                lockScrollViewBottom()
            }
        }
        
    }
    
    
    //methods controlling placements of views in scroll view
    func moveToCenter() {
        //Why should I set frameSizeHeight to contentOffset's y?
        scrollView.contentOffset = CGPoint(x: 0, y: scrollView.frame.size.height)
        centerScrollView.contentOffset = CGPoint(x: centerScrollView.frame.size.width, y: 0)
    }
    
    func lockScrollView() {
        let insets = UIEdgeInsets(top: -scrollView.frame.size.height, left: 0, bottom: -scrollView.frame.size.height, right: 0)
        scrollView.contentInset = insets
    }
    
    func lockScrollViewBottom() {
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: -scrollView.frame.size.height, right: 0)
        scrollView.contentInset = insets
    }
    
    func lockScrollViewTop() {
        let insets = UIEdgeInsets(top: -scrollView.frame.size.height, left: 0, bottom: 0, right: 0)
        scrollView.contentInset = insets
    }
    
    func unlockScrollView() {
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
}


extension FlashcardViewController {

    func updateLabels() {
        
        // Also needs to update text field content
        if cardIndex > 0 {
            flashcardView0.termInFlashCard.text = cards[cardIndex - 1].term
            
            //Make UILavel size fit to text
            //            flashCardView0.termInFlashCard.sizeToFit()
        } else {
            flashcardView0.termInFlashCard.text = ""
        }
        
        flashcardView1.termInFlashCard.text = cards[cardIndex].term
        
        //Make UILavel size fit to text
        //        flashCardView1.termInFlashCard.sizeToFit()
        
        if cardIndex + 1 < cards.count {
            flashcardView2.termInFlashCard.text = cards[cardIndex + 1].term
            
            //Make UILavel size fit to text
            //            flashCardView2.termInFlashCard.sizeToFit()
        } else {
            flashcardView2.termInFlashCard.text = nil
        }
    }
    
    func updateLabelsInLeftAndRight() {
        
        // Also needs to update text field content
        if cardIndex > 0 {
            flashcardViewL.definitionInFlashCard.text = cards[cardIndex - 1].definition
            flashcardViewR.definitionInFlashCard.text = cards[cardIndex - 1].definition
            
            //Make UILavel size fit to text
            //            flashCardViewL.definitionInFlashCard.sizeToFit()
            //            flashCardViewR.definitionInFlashCard.sizeToFit()
        } else {
            flashcardViewL.definitionInFlashCard.text = ""
            flashcardViewR.definitionInFlashCard.text = ""
        }
        
        flashcardViewL.definitionInFlashCard.text = cards[cardIndex].definition
        flashcardViewR.definitionInFlashCard.text = cards[cardIndex].definition
        
        //Make UILavel size fit to text
        //        flashCardViewL.definitionInFlashCard.sizeToFit()
        //        flashCardViewR.definitionInFlashCard.sizeToFit()
        
    }
    
}


extension FlashcardViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        
        if offset.y != scrollView.frame.size.height {
            
            if offset.y == 0 {
                cardIndex -= 1
            } else {
                cardIndex += 1
            }
            
            
            moveToCenter()
            
            updateLabels()
            updateLabelsInLeftAndRight()
            
            updateLocking()
        }
    }
    
}
