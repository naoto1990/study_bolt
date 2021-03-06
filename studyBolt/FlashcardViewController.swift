//
//  FlashcardViewController.swift
//  studyBolt
//
//  Created by Naoto Ohno on 2017/09/08.
//  Copyright © 2017年 Naoto Ohno. All rights reserved.
//

import UIKit
import RealmSwift
import GoogleMobileAds

class FlashcardViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var centerScrollView: UIScrollView!
    @IBOutlet weak var centerContainerView: UIView!
    
    @IBOutlet weak var flashcardView0: FlashcardView!
    @IBOutlet weak var flashcardView1: FlashcardView!
    @IBOutlet weak var flashcardView2: FlashcardView!
    @IBOutlet weak var flashcardViewL: FlashcardView!
    @IBOutlet weak var flashcardViewR: FlashcardView!
    
    
    
    var cards: Results<Card>!
    
    // カードの現在ポジションを表す値
    var cardIndex = 0
    
    var bannerView: GADBannerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        view.addSubview(bannerView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // TODO: 下記必要あるか確認。必要なければ全箇所から削除
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(FlashcardViewController.onOrientationChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        scrollView.showsVerticalScrollIndicator = false
        centerScrollView.showsHorizontalScrollIndicator = false
        
        updateLabels()
        updateLabelsInLeftAndRight()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        moveToCenter()
        updateLocking()
    }
    
    func onOrientationChange() {
        // 現在のデバイスの向きを取得
        let deviceOrientation: UIDeviceOrientation!  = UIDevice.current.orientation
        
        if UIDeviceOrientationIsLandscape(deviceOrientation) {
            //横向きの判定。向きに従い位置を調整
            moveToCenter()
            
        } else if UIDeviceOrientationIsPortrait(deviceOrientation){
            //縦向きの判定。向きに従い位置を調整
            moveToCenter()
            
        }
        
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }

}


extension FlashcardViewController {
    
    func updateLocking() {
        unlockScrollView()
        if 0 >= cardIndex {
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
    
    
    func moveToCenter() {
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
        
        // カードスワイプ画面で2枚目以降にいる場合、直前の画面のUILabelに対応するTermデータを反映
        if cardIndex > 0 {
            flashcardView0.termInFlashCard.text = cards[cardIndex - 1].term
            
        } else {
            flashcardView0.termInFlashCard.text = ""
        }
        
        flashcardView1.termInFlashCard.text = cards[cardIndex].term
        
        // 次の画面にカードデータが存在する場合、次の画面のUILabelに対応するTermデータを反映
        if cards.count > cardIndex + 1 {
            flashcardView2.termInFlashCard.text = cards[cardIndex + 1].term
        
        } else {
            flashcardView2.termInFlashCard.text = nil
        }
    }
    
    func updateLabelsInLeftAndRight() {
        
        // カードスワイプ画面で2枚目以降にいる場合、直前の画面のUILabelに対応するDefinitionデータを反映
        if cardIndex > 0 {
            flashcardViewL.definitionInFlashCard.text = cards[cardIndex - 1].definition
            flashcardViewR.definitionInFlashCard.text = cards[cardIndex - 1].definition
        
        } else {
            flashcardViewL.definitionInFlashCard.text = ""
            flashcardViewR.definitionInFlashCard.text = ""
        }
        
        flashcardViewL.definitionInFlashCard.text = cards[cardIndex].definition
        flashcardViewR.definitionInFlashCard.text = cards[cardIndex].definition
        
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

extension FlashcardViewController: GADBannerViewDelegate {
    
}
