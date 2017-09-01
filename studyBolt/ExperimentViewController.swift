//
//  ExperimentViewController.swift
//  studyBolt
//
//  Created by Naoto Ohno on 2017/09/01.
//  Copyright © 2017年 Naoto Ohno. All rights reserved.
//

import UIKit

class ExperimentViewController: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func lock1(_ sender: Any) {
        lockScrollView()
    }
    
    @IBAction func lock2(_ sender: Any) {
        lockScrollViewRight()
    }
    
    @IBAction func lock3(_ sender: Any) {
        lockScrollViewLeft()
    }
    
    
    @IBAction func unlock(_ sender: Any) {
        unlockScrollView()
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

}
